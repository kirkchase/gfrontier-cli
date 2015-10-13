import Foundation

public class Card: CustomStringConvertible, CustomDebugStringConvertible {
    private static var count = 0;
    
    // MARK: Properties
    // header
    var key  = ""
    var type  = Empty_CardType
    var name  = ""
    var points = 0
    
    // footer
    var series  = "The Unknown"
    var serial = count++;
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
        return "\(type.short): \(name)"
    }
    
    public init() {
    }
    
    public init(data:JSON) {
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
            self.duration = GFManager.sharedInstance.durations[data["duration"].asString!] ?? Empty_CardDuration
            self.turns = data["turns"].asInt ?? 0
        } else {
            self.key = "ERROR"
            self.name = data["name"].asString ?? ""
        }
    }
    
    private func getJsonObject<T: JsonAble>(data:JSON,  emptyType:T)->T {
        if !data.isError {
            return T(data:data)
        } else {
            return emptyType
        }
    }
    
}

