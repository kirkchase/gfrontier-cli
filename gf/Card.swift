import Foundation

public class Card: CustomStringConvertible, CustomDebugStringConvertible, JsonAble {
    // MARK: Properties
    // header
    var key  = ""
    var type  = Empty_CardType
    var name  = ""
    var points = 0
    var tags = [CardTag]()
    
    // center
    var image:String? = nil // Visitor, Location
    var instructions:String? = nil // Mission, Action, Event, Resource, Marker
    var moreTags = [CardTag]() // Resource, Marker
    var attributes = [String: Int]() // Resource, Marker
    var actions = [CardAction]()
    
    
    // footer
    var series  = "The Unknown"
    var serial = 0
    var copyrightDate = NSDate()
    var copyrightHolder = "Kirk Chase"
    var destiny = 0;
    var placement:String?
    var duration:CardDuration? = nil
    var turns:CardUsage? = nil
    
    // MARK: Computed Properties
    public var description: String {
        return "\(type.short): \(name)"
    }
    
    public var debugDescription: String {
        return json
    }
    
    public var jsonContents: String {
        var working = jsonData("key", key)
        working += jsonData("type", type.key)
        working += jsonData("name", name)
        working += jsonData("points", points)
        working += jsonData("series", series)
        working += jsonData("serial", serial)
        working += jsonData("destiny", destiny)
        if let placement = placement {
            working += jsonData("placement", placement)
        }
        if let duration = duration {
            working += jsonData("duration", duration.key)
        }
        if let image = image {
            working += jsonData("image", image)
        }
        if let instructions = instructions {
            working += jsonData("instructions", instructions)
        }
        
        if tags.count > 0 {
            working += jsonTags("tags", tags)
        }
        if moreTags.count > 0 {
            working += jsonTags("moreTags", moreTags)
        }
        if let turns = turns {
            working += jsonData("turns", turns.key)
        }
        
        // need to end on an always so that it has no comma
        working += jsonData("copyrightDate", copyrightDate.description)
        working += jsonData("copyrightHolder", copyrightHolder, false)

        return working
    }
    
    private func jsonTags(key: String, _ tags:[CardTag]) -> String {
        var working = "\"\(key)\":["
        
        for i in 0..<(tags.count - 1) {
            working += tags[i].key + ","
        }
        working += tags[tags.count - 1].key + "]"
        return working
    }
    
    public var json: String {
        return "{" + jsonContents + "}"
    }
    
    
    public init() {
    }
    
    public required init(data:JSON) {
        if let key = data["key"].asString {
            self.key = key
            self.type = GFManager.sharedInstance.cardTypes[data["type"].asString!] ?? Empty_CardType
            self.name = data["name"].asString!
            self.points = data["points"].asInt ?? 0
            self.series = data["series"].asString ?? "The Unknown"
            self.serial = data["serial"].asInt ?? 0
            self.copyrightDate = data["copyrightDate"].asDate ?? NSDate()
            self.copyrightHolder = data["copyrightHolder"].asString ?? "Kirk Chase"
            self.destiny = data["destiny"].asInt ?? 0
            self.placement = data["placement"].asString ?? ""
            self.duration = GFManager.sharedInstance.durations[data["duration"].asString ?? "Game"] ?? GFManager.sharedInstance.durations["Game"]!
//            self.turns = data["turns"].asInt ?? 0
            
            // tags
            if listValid("tags", data) {
                loadTags("tags", container:tags, data:data)
            }
            self.image = data["image"].asString ?? ""
            self.instructions = data["instructions"].asString ?? ""

            // moreTags
            if listValid("moreTags", data) {
                loadTags("moreTags", container:tags, data:data)
            }

            if !data["attributes"].isError {
                loadAttributes(data["attributes"])
            }
            // actions
            if listValid("actions", data) {
                loadActions(data)
            }
            
        } else {
            self.key = "ERROR"
            self.name = data["name"].asString ?? ""
        }
    }
    
    private func initAttributesSkills() {
        attributes.removeAll()
        attributes["HIP"] = 0;
        attributes["DMG"] = 0;
        attributes["TAC"] = 0;
        attributes["DEF"] = 0;
        attributes["CMD"] = 0;
        attributes["DIP"] = 0;
        attributes["SCI"] = 0;
        attributes["ENG"] = 0;
    }
    
    private func loadAttributes(data:JSON) {
        loadConditionalAttribute("HIT", data)
        loadConditionalAttribute("DMG", data)
        loadConditionalAttribute("TAC", data)
        loadConditionalAttribute("DEF", data)
        loadConditionalAttribute("CMD", data)
        loadConditionalAttribute("DIP", data)
        loadConditionalAttribute("SCI", data)
        loadConditionalAttribute("ENG", data)
    }
    
    private func loadConditionalAttribute(key:String, _ data:JSON) {
        if !data[key].isError {
            attributes[key] = data[key].asInt!
        }
    }
    
    private func loadActions(data:JSON) {
        actions.removeAll()
        let working = data["actions"].asArray!
        for i in 0..<working.count {
            let action = CardAction(data:working[i])
            actions.append(action)
        }
    }
    
    private func loadTags(key:String, var container:[CardTag], data:JSON) {
        let working = data[key].asArray!
        for i in 0..<working.count {
            if let tag = working[i].asString {
                container.append(GFManager.sharedInstance.tags[tag]!)
            }
        }
    }
    
    private func listValid(key:String, _ data:JSON) -> Bool {
        if !data[key].isArray {
            return false
        }
        if data[key].asArray?.count == 0 {
            return false;
        }
        
        return true
    }
    
    private func getJsonObject<T: JsonAble>(data:JSON,  emptyType:T)->T {
        if !data.isError {
            return T(data:data)
        } else {
            return emptyType
        }
    }
    
}

