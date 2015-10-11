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
let json = JSON.unwrap("wiwiwi");
if let filePath = NSBundle.mainBundle().pathForResource("carddata",ofType:"json") {
    var data = JSON.parse(condenseWhitespace(readFileInPath(filePath)!))
    var records = data["records"][0]["name"].asString!
    print("hello")
//    if let data = JSON.unwrap(condenseWhitespace(readFileInPath(filePath)!)) {
//    if let data = parseJsonData(condenseWhitespace(readFileInPath(filePath)!)) {
//        var something = data.objectForKey("records")
//        if something is NSArray {
//            
//            var records = Array(arrayLiteral: something)
//            var  elem0 = records[0]!
//            print("Array")
//        }
//    } else {
//        print("** Error ** carddata.json not valid")
//        exit(EXIT_FAILURE)
//    }
    //    var json = try parseJsonData(condenseWhitespace(data!))
    
} else {
    print("** Error ** carddata.json not found")
    exit(EXIT_FAILURE)
}
exit(EXIT_SUCCESS)