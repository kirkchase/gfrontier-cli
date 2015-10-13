//
//  JsonAble.swift
//  gf
//
//  Created by KChase on 10/13/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

protocol JsonAble {
    var jsonContents: String { get }
    var json: String { get }
    init()
    init(data:JSON)
}