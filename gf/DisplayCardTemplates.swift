import Foundation

private let CARD_GROUPING = 5

private let displayMenuMap: [(title:String, payload:Any?, action: (_: Any?) -> String?)] = [
    ("All", nil, dislplayCards),
    ("Locations", GFManager.sharedInstance.cardTypes["Location"], dislplayCards),
    ("Visitors", GFManager.sharedInstance.cardTypes["Visitor"], dislplayCards),
    ("Resources", GFManager.sharedInstance.cardTypes["Resource"], dislplayCards),
    ("Missions", GFManager.sharedInstance.cardTypes["Mission"], dislplayCards),
    ("Events", GFManager.sharedInstance.cardTypes["Event"], dislplayCards),
    ("Actions", GFManager.sharedInstance.cardTypes["Action"], dislplayCards),
    ("Markers", GFManager.sharedInstance.cardTypes["Marker"], dislplayCards),
    ("Cancel", nil, cancelMenu)
]

private func dislplayCards(parameter: Any?) -> String? {
//    let cardType = GFManager.sharedInstance.cardTypes[name]
//    let cards = getCardsByType(cardType)
//    
//    return name;
    return nil;
}

private func cancelMenu(parameter: Any?) -> String? {
    finished = true;
    return "cancel"
}

private var finished = false;

public func displayCardTemplates(parameter: Any?) -> String? {
    
//    repeat {
//    var cards = [Card]()
    
//    let action: String = getMenuAction("** Display Cards **", actionMap: displayMenuMap);
//   } while !finished
    //
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
    return "aal"
}

private func getCardsByType(type: CardType?) -> [Card] {
    var cards = [Card]()
    
    if let type = type {
        for card in GFManager.sharedInstance.cardTemplates.values {
            if card.type.key == type.key {
                cards.append(card)
            }
        }
    } else {
        cards.appendContentsOf(GFManager.sharedInstance.cardTemplates.values)
    }
    
    return cards
}
