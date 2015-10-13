//
//  LabelValue.swift
//  gf
//
//  Created by KChase on 10/12/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

public class LabelValue: Label {
    // MARK: Properties
    var value = 0
    
    // MARK: Computed Properties
    public override var description: String {
        if (name == short) {
            return "\(name) = \(value)"
        } else {
            return "\(short) \(name) = \(value)"
        }
    }
    
    override public var jsonContents: String {
        return super.jsonContents + ",\"value\":" + String(value)
    }

    // MARK: Initializers
    public required init() {
        super.init()
    }
    
    public init(key:String, name:String, short:String, value:Int) {
        super.init(key: key, name: name, short: short)
        self.value = value
    }
    
    public required init(data:JSON) {
        super.init(data: data)
        self.value = data["name"].asInt ?? 0
    }
    
    
}