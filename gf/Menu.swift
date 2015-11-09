//
//  Menu.swift
//  gf
//
//  Created by KChase on 11/7/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

public func returnNil(parameter: Any?) -> String? {
    return nil
}

public class Menu {
    let title: String
    let payload: Any?
    let action: (_: Any?) -> String?
    
    
    init(_ title: String, payload: Any?, _ action:(parameter: Any?) -> String?) {
        self.title = title
        self.payload = payload
        self.action = action
    }
}
