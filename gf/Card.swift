import Foundation

public class Card: CustomStringConvertible, CustomDebugStringConvertible {
    var name: String
    var type: CardType
    var key: String
    var series: String
    var copyrightDate: NSDate
    var copyrightHolder: String
    var identityTags = [CardTag]()
    var itemTags = [CardTag]()
    var imageName = "";
    var information = "";
    
    
    public init(name: String, type: CardType, key: String) {
        self.type = type
        self.name = name
        self.key = key
        series = "test series"
        copyrightDate = NSDate()
        copyrightHolder = "Kirk Chase"
    }
    
    public convenience init(name: String, type: CardType) {
        let generatedKey = name.lowercaseString
        self.init(name: name, type: type, key: generatedKey)
    }
    
    public convenience init(type: CardType) {
        let name = "testname"
        let generatedKey = name.lowercaseString
        self.init(name: name, type: type, key: generatedKey)
    }
    
    public var description: String {
        return "\(type.rawValue): \(name)"
    }
    
    public var debugDescription: String {
        return "\(type.rawValue): \(name)"
    }
    
}

