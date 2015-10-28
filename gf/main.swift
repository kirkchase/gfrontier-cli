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
if let filePath = NSBundle.mainBundle().pathForResource("carddata",ofType:"json") {
    var data = JSON.parse(condenseWhitespace(readFileInPath(filePath)!))
    GFManager.sharedInstance.load(data)
    
    repeat {
        let action: String = getMainMenuAction();
        switch action  {
        case "quit":
            exitApp = true;
        default:
            print("I am sorry, I don't understand \"\(action)\"")
        }
    } while !exitApp
    
} else {
    print("** Error ** carddata.json not found")
    exit(EXIT_FAILURE)
}
exit(EXIT_SUCCESS)
