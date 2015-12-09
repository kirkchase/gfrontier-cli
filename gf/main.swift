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
if let filePath = NSBundle.mainBundle().pathForResource("gfdata/carddata",ofType:"json") {
    print("Initializing data...")
    var data = JSON.parse(condenseWhitespace(readFileInPath(filePath)!))
    GFManager.sharedInstance.load(data)
}

//TODO need to load in images

if let filePath = NSBundle.mainBundle().pathForResource("gfdata/cards",ofType:"json") {
    print("Loading cards...")
    var data = JSON.parse(condenseWhitespace(readFileInPath(filePath)!))
    GFManager.sharedInstance.load(data)
}
if let error = gameError {
    print("** Error ** \(error)")
    exit(EXIT_FAILURE)
}

repeat {
    if let action = displayMainMenu(nil) {
        if action == "quit" {
            exitApp = true
        }
    }

} while !exitApp && gameError != nil


exit(EXIT_SUCCESS)
