//
//  MainMenu.swift
//  gf
//
//  Created by KChase on 11/9/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

private let mainMenu: [(title:String, payload:Any?, action: (_: Any?) -> String?)] = [
    ("Constants", nil, displayConstantsMenu),
    ("View cards", nil, displayCardTemplates),
    //    ("constants", "Constants - View constants (types, tags, etc.)"),
    ("Quit", "quit", returnNil)
]


public func displayMainMenu(parameter: Any?) -> String? {
    let index = doMenuSelection("** Main Menu **", menuItems: mainMenu)
    
    mainMenu[index].action(mainMenu[index].payload)
    return nil
}