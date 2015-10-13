import Foundation

public class Stack: CustomStringConvertible, CustomDebugStringConvertible {
    var name: String
    var type: StackType
    var state: StackState = StackState(key: "", name: "", short: "")
    var cards = [Card]()
    
    public init(name:String, type:StackType) {
        self.name = name
        self.type = type;
    }
    
    public func add(card:Card) {
        cards.append(card)
        
    }
    
    public func remove(index:Int) -> Card? {
        if !validRange(index) {
            return nil
        }
        
        return cards.removeAtIndex(index)
    }
    
    // find by Card
    public func index(card:Card) -> Int? {
        return _index(card, fromIndex: 0, compare: equalityByKey)
    }
    
//    public func index(type:CardType) -> Int? {
//        let card = Card(name: "test", type: type, key: "test")
//        return _index(card, fromIndex:0, compare: equalityByCardType)
//    }
    
    public func _index(card:Card, fromIndex index:Int, compare: (Card, Card)->Bool) ->Int? {
        if validRange(index) {
            for i in index..<cards.count {
                if compare(cards[i], card) {
                    return i
                }
            }
        }
        
        return nil
    }
    
    public subscript(index: Int) -> Card? {
        if !validRange(index) {
            return nil
        }
        return cards[index]
    }
    
    public func validRange(index: Int) -> Bool{
        return (index >= 0 && index < cards.count)
    }
    
    private let equalityByKey : (Card, Card) -> Bool = {
        return $0.key == $1.key
    }
    
    private let equalityByCardType : (Card, Card) -> Bool = {
        return $0.type.key == $1.type.key
    }
    
    public var description: String {
        return "Stack: \(cards.count)"
    }
    
    public var debugDescription: String {
        return "Stack: \(cards.count)"
    }

}


