//
//  Label.swift
//  gf
//
//  Created by KChase on 10/12/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

public class Label: CustomStringConvertible, CustomDebugStringConvertible {
    // MARK: Properties
    var key = ""
    var name = ""
    var short = ""

    // MARK: Computed Properties
    public var description: String {
        if (name == short) {
            return "\(name)"
        } else {
            return "\(short) \(name)"
        }
    }
    
    public var debugDescription: String {
        return "\(short) \(name) (\(key))"
    }
    
    public var json: String {
        return "{\"id\":\"" + key + "\",\"name\":\"" + name + "\",\"short\":\"" + short + "\"}"
    }

    // MARK: Initializers
    public init(key:String, name:String, short:String) {
        self.key = key
        self.name = name
        self.short = short
    }
    
    convenience public init(data:JSON) {
        self.init(key:data["key"].asString ?? "", name:data["name"].asString ?? "", short:data["short"].asString ?? "")
    }
    
    // MARK: Methods
}