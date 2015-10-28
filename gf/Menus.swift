//
//  Menus.swift
//  gf
//
//  Created by KChase on 10/20/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

private let mainMenuMap: [(key:String, value:String)] = [
    ("cards", "Cards - View cards"),
    ("quit", "Quit")
]


public func getMainMenuAction() -> String {
    displayMainMenu()
    return getMenuAction(mainMenuMap)
}

private func displayMainMenu() {
    print("\n** Galactic Frontier Menu **")
    var count = 1
    for (_, value) in mainMenuMap {
        print(" \(count). \(value)")
        count++
    }
    print("")
    
}

private func getMenuAction(menus:[(key:String, value:String)]) -> String {
    var action = "";
    repeat {
        print(">> ", terminator:"")
         //stdin.read()
        if let item:String = readLine() {
            action = item.lowercaseString
            
            if let command = isAction(action, menus) {
                return command
            }
        }
    } while true
}

private func isAction(search:String, _ menus:[(key:String, value:String)]) -> String? {
    for i in 0..<menus.count {
        let action = menus[i]

        if search == String(i + 1) {
            return action.key
        } else if search == action.key {
            return action.key
        }
    }
    
    return nil
}

