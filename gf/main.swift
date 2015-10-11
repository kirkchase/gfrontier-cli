//
//  main.swift
//  gf
//
//  Created by Kirk Chase on 10/10/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

let stdin = StreamScanner.standardInput

print("Hello, World!")

let filePath = NSBundle.mainBundle().pathForResource("carddata",ofType:"json")
print(readFileInPath(filePath!)!)