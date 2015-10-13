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
    
}

