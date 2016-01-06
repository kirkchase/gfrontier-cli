import Foundation

private let topLevelMenu: [(title:String, payload:Any?, action: (_: Any?) -> String?)] = [
    ("CardTags", nil, displayTags),
    ("CardActionTypes", nil, displayCardActionTypes),
    ("CardTypes", nil, displayCardTypes),
    ("Cancel", "cancel", returnNil)
]


public func displayConstantsMenu(parameter: Any?) -> String? {
    var exitMenu = false
    repeat {
        let index = doMenuSelection("** Display Game Constants **", menuItems: topLevelMenu)
        let result = topLevelMenu[index].action(topLevelMenu[index].payload)
        if result == nil {
            exitMenu = true
        }
    } while exitMenu == false
    
    return "displayConstantsMenu"
}

private func displayTags(payload:Any?) -> String? {
    print("")
    print("*** Card Tags **")
    var count = 1
    var items = [CardTag]();
    for (_, tag) in GFManager.sharedInstance.tags {
        items.append(tag)

    }
    items.sortInPlace {$0.key < $1.key}
    for tag in items {
        print("\(count). \(tag.description)")
        if (count % 10) == 0 {
            pauseit()
        }
        count++;
        
    }
    pauseit();
    return "back"
}

private func displayCardActionTypes(payload:Any?) -> String? {
    print("")
    print("*** Card Action Types **")
    var count = 1
    var items = [CardActionType]();
    for (_, action) in GFManager.sharedInstance.actionTypes {
        items.append(action)
        
    }
    items.sortInPlace {$0.key < $1.key}
    for action in items {
        print("\(count). \(action.description)")
        if (count % 10) == 0 {
            pauseit()
        }
        count++;
        
    }
    pauseit();
    return "back"
}

private func displayCardTypes(payload:Any?) -> String? {
    print("")
    print("*** Card Types **")
    var count = 1
    var items = [CardType]();
    for (_, action) in GFManager.sharedInstance.cardTypes {
        items.append(action)
        
    }
    items.sortInPlace {$0.key < $1.key}
    for action in items {
        print("\(count). \(action.description)")
        if (count % 10) == 0 {
            pauseit()
        }
        count++;
        
    }
    pauseit();
    return "back"
}