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
    var destiny = 0
    var placement:String?
    var usages:CardUsage? = nil
    
    var series  = "The Unknown"
    var serial = 0
    var copyrightDate = 2015
    var copyrightHolder = "Kirk Chase"
    
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
        working += jsonDataArray("tags", jsonTags(tags))

        working += jsonData("image", image)
        working += jsonData("instructions", instructions)
        working += jsonDataArray("moreTags", jsonTags(moreTags))
        working += jsonDataArray("attributes", jsonAttributes())
        working += jsonDataArray("actions", jsonActions())
        

        // need to end on an always so that it has no comma
        working += jsonData("destiny", destiny)
        working += jsonData("placement", placement)
        if let usages = usages {
            working += jsonData("usages", usages.key)
        }
        working += jsonData("series", series)
        working += jsonData("serial", serial)
        
        working += jsonData("copyrightDate", copyrightDate)
        working += jsonData("copyrightHolder", copyrightHolder, false)

        return working
    }
    
    private func jsonTags(tags:[CardTag]) -> String {
        var working = ""
        
        var addComma = false
        for tag in tags {
            if addComma {
                working += ","
            }
            working += "\"" + tag.key + "\""

            addComma = true;
        }
        
        return working
    }
    
    private func jsonActions() -> String {
        var working = ""
        
        var addComma = false;
        for action in actions {
                if addComma {
                    working += ","
                }
                working += action.json
                
                addComma = true
        }
        
        return working;
    }
    
    private func jsonAttributes() -> String {
        var working = ""
        
        var addComma = false;
        for (key, value) in attributes {
            let node = jsonData(key,value, false)
            if node.length > 0 {
                if addComma {
                    working += ","
                }
                working += "{" + node + "}"

                addComma = true
            }
        }
        
        return working;
    }
    
    public var json: String {
        return "{" + jsonContents + "}"
    }
    
    
    public init() {
    }
    
    public required init(data:JSON) {
        if let key = data["key"].asString {
            self.key = key
            self.type = GFManager.sharedInstance.cardTypes[data["type"].asString ?? "Resource"] ?? CardType(key: "Unknown CardType", name: "Unknown Cardype", short: data["type"].asString!)
            self.name = data["name"].asString!
            self.points = data["points"].asInt ?? 0
            self.series = data["series"].asString ?? "The Unknown"
            self.serial = data["serial"].asInt ?? 0
            self.copyrightDate = data["copyrightDate"].asInt ?? 2015
            self.copyrightHolder = data["copyrightHolder"].asString ?? "Kirk Chase"
            self.destiny = data["destiny"].asInt ?? 0
            self.placement = data["placement"].asString ?? nil
            
            if !data["usages"].isError {
                self.usages = GFManager.sharedInstance.usages[data["usages"].asString!]
            }
            
            // tags
            if listValid("tags", data) {
                tags = loadTags("tags", container:tags, data:data)
            }
            self.image = data["image"].asString ?? ""
            self.instructions = GFManager.sharedInstance.replaceTokens(data["instructions"].asString ?? "")

            // moreTags
            if listValid("moreTags", data) {
                moreTags = loadTags("moreTags", container:moreTags, data:data)
            }

            if listValid("attributes",data) {
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
        attributes["USE"] = 0;
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
        initAttributesSkills()
        let working = data.asArray!
        for i in 0..<working.count {
            let dictionary = working[i].asDictionary!
            for (key, value) in dictionary {
                attributes[key] = value.asInt!
            }
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
    
    private func loadTags(key:String, var container:[CardTag], data:JSON) -> [CardTag] {
        let working = data[key].asArray!
        for i in 0..<working.count {
            if let key = working[i].asString {
                let tag = GFManager.sharedInstance.tags[key]!
                container.append(tag)
            }
        }
        
        return container
    }
    
    private func listValid(key:String, _ data:JSON) -> Bool {
        if !data[key].isArray {
            return false
        }
        let array = data[key].asArray!
        if array.count == 0 {
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

