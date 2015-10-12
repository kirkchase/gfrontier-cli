//
//  main.swift
//  gf
//
//  Created by Kirk Chase on 10/10/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

let stdin = StreamScanner.standardInput

print("Galactic Frontier")
print("\nInitializing data...\n")
if let filePath = NSBundle.mainBundle().pathForResource("carddata",ofType:"json") {
    var data = JSON.parse(condenseWhitespace(readFileInPath(filePath)!))
    if !data["CardType"].isNull {
        for index in 0..<data["CardType"].length {
            let record = data["CardType"][index]
            print(record["symbol"].asString! + " " + record["name"].asString!)
        }
    }
} else {
    print("** Error ** carddata.json not found")
    exit(EXIT_FAILURE)
}
exit(EXIT_SUCCESS)