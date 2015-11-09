import Foundation

private let topLevelMenu: [(title:String, payload:Any?, action: (_: Any?) -> String?)] = [
    ("CardTags", GFManager.sharedInstance.tags, displayTags),
    ("CardActionTypes", nil, returnNil),
    ("CardDurations", nil, returnNil),
    ("CardTypes", nil, returnNil),
    //    ("constants", "Constants - View constants (types, tags, etc.)"),
    ("Cancel", "cancel", returnNil)
]


public func displayConstantsMenu(parameter: Any?) -> String? {
    let index = doMenuSelection("** Display Game Constants **", menuItems: topLevelMenu)
    
    topLevelMenu[index].action(topLevelMenu[index].payload)
    return "constants"
}

private func displayTags(payload:Any?) -> String? {
    print("")
    print("*** Card Tags **")
    for (_, tag) in GFManager.sharedInstance.tags {
        print(tag.description)
    }
    pauseit();
    return "foo"
}