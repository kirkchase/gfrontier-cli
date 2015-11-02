import Foundation

private let CARD_GROUPING = 5

private let displayMenuMap: [(key:String, value:String)] = [
    ("all", "All"),
    ("locations", "Locations"),
    ("visitors", "Visitors"),
    ("resources", "Resources"),
    ("missions", "Missions"),
    ("events", "Events"),
    ("actions", "Actions"),
    ("markers", "Markers"),
    ("cancel", "Cancel")
]


public func displayAllCards() {
    var finished = false;
    //    var errors = false;
    
    var cards = [Card]()
    
    repeat {
        let action: String = getMenuAction("** Display Cards **", actionMap: displayMenuMap);
        switch action {
        case "all":
            cards = getCardsByType(nil)
        case "locations":
            cards = getCardsByType(GFManager.sharedInstance.cardTypes["Location"])
        case "visitors":
            cards = getCardsByType(GFManager.sharedInstance.cardTypes["Visitor"])
        case "resources":
            cards = getCardsByType(GFManager.sharedInstance.cardTypes["Resource"])
        case "missions":
            cards = getCardsByType(GFManager.sharedInstance.cardTypes["Mission"])
        case "events":
            cards = getCardsByType(GFManager.sharedInstance.cardTypes["Event"])
        case "actions":
            cards = getCardsByType(GFManager.sharedInstance.cardTypes["Action"])
        case "markers":
            cards = getCardsByType(GFManager.sharedInstance.cardTypes["Marker"])
        case "cancel":
            finished = true
        default:
            print("I am sorry, \"\(action)\" is not implemented yet.")
            finished = true
        }
        
    } while !finished
    //    print("All Cards")
    //
    //    var count = 0
    //    for card in GFManager.sharedInstance.cardTemplates.values {
    //        if count == CARD_GROUPING {
    //            pause(">>>", blanks: false)
    //            count = 0
    //        } else {
    //            count++
    //        }
    //
    //        // print card
    //        let points = (card.points > 0) ? String(card.points) : ""
    //        let fi = String(format:"%@ %-20@ %3@", card.type.short, card.name.stringByPaddingToLength(20, withString: " ", startingAtIndex: 0), points.stringByPaddingToLength(3, withString: " ", startingAtIndex: 0))
    //
    //        print(fi)
    //        print("**********")
    //    }
    
}

private func getCardsByType(type: CardType?) -> [Card] {
    var cards = [Card]()
    
    if let type = type {
            for card in GFManager.sharedInstance.cardTemplates.values {
                if card.type.key == type.key {
                    cards.append(card)
                }
            }
    }
    
    return cards
}
