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
    
    public override var debugDescription: String {
        return "\(short) \(name) (\(key)) = \(value)"
    }
    
    public override var json: String {
        return "{\"key\":\""
            + key +
            "\",\"name\":\"" +
            name +
            "\",\"short\":\"" +
            short +
            "\",\"value\":" +
            String(value) + "}"
    }
    
    // MARK: Initializers
    public init(key:String, name:String, short:String, value:Int) {
        super.init(key: key, name: name, short: short)
        self.value = value
    }
    
    convenience public init(data:JSON) {
        self.init(key:data["key"].asString ?? "", name:data["name"].asString ?? "", short:data["short"].asString ?? "", value:data["name"].asInt ?? 0)
    }
    
    
}