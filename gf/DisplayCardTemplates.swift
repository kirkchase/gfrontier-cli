import Foundation

private let CARD_GROUPING = 5

private let displayMenuMap: [(title:String, payload:Any?, action: (_: Any?) -> String?)] = [
    ("All", nil, displayCards),
    ("Locations", GFManager.sharedInstance.cardTypes["Location"], displayCards),
    ("Visitors", GFManager.sharedInstance.cardTypes["Visitor"], displayCards),
    ("Resources", GFManager.sharedInstance.cardTypes["Resource"], displayCards),
    ("Missions", GFManager.sharedInstance.cardTypes["Mission"], displayCards),
    ("Events", GFManager.sharedInstance.cardTypes["Event"], displayCards),
    ("Actions", GFManager.sharedInstance.cardTypes["Action"], displayCards),
    ("Markers", GFManager.sharedInstance.cardTypes["Marker"], displayCards),
    ("Cancel", nil, cancelMenu)
]

private func displayCards(parameter: Any?) -> String? {
    let cards = getCardsByType(parameter as? CardType)
    
    for card in cards {
        card.printPrettyDescription()
        pauseit(true)
    }
    pauseit(true)
    
    return "displayCards";
}

private func cancelMenu(parameter: Any?) -> String? {
    finished = true;
    return nil
}

private var finished = false

public func displayCardTemplates(parameter: Any?) -> String? {
    finished = false
    repeat {
        let index = doMenuSelection("** Display Game Constants **", menuItems: displayMenuMap)
        displayMenuMap[index].action(displayMenuMap[index].payload)
    } while finished == false
    
    return "displayCardTemplates"
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
