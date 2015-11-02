//
//  main.swift
//  gf
//
//  Created by Kirk Chase on 10/10/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

let stdin = StreamScanner.standardInput

public var exitApp = false

print("Galactic Frontier")
print("\nInitializing data...\n")
if let filePath = NSBundle.mainBundle().pathForResource("gfdata/carddata",ofType:"json") {
    var data = JSON.parse(condenseWhitespace(readFileInPath(filePath)!))
    GFManager.sharedInstance.load(data)
    
    repeat {
        let action: String = getMenuAction("*** GF Main Menu ***", actionMap: mainMenuMap);
        switch action  {
            case "cards":
                displayAllCards()
        case "quit":
            exitApp = true
        default:
            print("I am sorry, \"\(action)\" is not implemented yet.")
            exitApp = true
        }
    } while !exitApp
    
} else {
    print("** Error ** carddata.json not found")
    exit(EXIT_FAILURE)
}
exit(EXIT_SUCCESS)
