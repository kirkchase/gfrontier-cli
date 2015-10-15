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
    var image = "" // Visitor, Location
    var instructions = "" // Mission, Action, Event, Resource, Marker
    var moreTags = [CardTag]() // Resource, Marker
    var attributes = [String: CardAttribute]() // Resource, Marker
    var skills = [CardAttribute]() // Resource, Marker
    var actions = [CardAction]()
    
    
    // footer
    var series  = "The Unknown"
    var serial = 0
    var copyrightDate = NSDate()
    var copyrightHolder = "Kirk Chase"
    var destiny = 0;
    var placement = ""
    var duration = Empty_CardDuration
    var turns = 0
    
    // MARK: Computed Properties
    public var description: String {
        return "\(type.short): \(name)"
    }
    
    public var debugDescription: String {
        return json
    }
    
    public var jsonContents: String {
        return ""
    }
    
    public var json: String {
        return "{" + jsonContents + "}"
    }
    
    
    public init() {
    }
    
    public required init(data:JSON) {
/*
        
        // center
        var attributes = [CardAttribute]() // Resource, Marker
        var skills = [CardAttribute]() // Resource, Marker
        var actionEvents = [CardAction]()
*/
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
            self.turns = data["turns"].asInt ?? 0
            
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

            // attributes
            // skills
            initAttributesSkills()
            if listValid("attributes", data) {
                let working = data["attributes"].asArray!
                for i in 0..<working.count {
                    let attribute = working[i].asInt!
                    print(attribute)
                }
            }
            // actions
            if listValid("actions", data) {
                loadActions(data["actions"])
            }
            
        } else {
            self.key = "ERROR"
            self.name = data["name"].asString ?? ""
        }
    }
    
    private func initAttributesSkills() {
        attributes.removeAll()
        attributes["HP"] = 0;
        attributes["DM"] = 0;
        attributes["TC"] = 0;
        attributes["DF"] = 0;
        attributes["CM"] = 0;
        attributes["DP"] = 0;
        attributes["SC"] = 0;
        attributes["EN"] = 0;
    }
    
    private func loadAttributes(data:JSON) {
        let working = data["attributes"].asArray!
        for i in 0..<working.count {
            let attribute = working[i].asInt!
            switch i {
            case 1:
                attributes["HP"] = attribute
            case 2:
                attributes["DM"] = attribute
            case 3:
                attributes["TC"] = attribute
            case 4:
                attributes["DF"] = attribute
            default:
                print("More attributes than expected");
            }
        }
        
    }
    
    private func loadActions(data:JSON) {
        actions.removeAll()
        let working = data[key].asArray!
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

