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
public var gameError : String? = nil

print("Galactic Frontier")
print("Initializing data...")
if let filePath = NSBundle.mainBundle().pathForResource("gfdata/carddata",ofType:"json") {
    var data = JSON.parse(condenseWhitespace(readFileInPath(filePath)!))
    GFManager.sharedInstance.load(data)
}
print("Loading cards...")
if let filePath = NSBundle.mainBundle().pathForResource("gfdata/cards",ofType:"json"), let error = gameError {
    var data = JSON.parse(condenseWhitespace(readFileInPath(filePath)!))
    GFManager.sharedInstance.load(data)
}

repeat {
    if let action = displayMainMenu(nil) {
        if action == "quit" {
            exitApp = true
        }
    }

} while !exitApp && gameError != nil

if let error = gameError {
    print("** Error ** \(error)")
    exit(EXIT_FAILURE)
}

exit(EXIT_SUCCESS)
