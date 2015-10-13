//
//  Label.swift
//  gf
//
//  Created by KChase on 10/12/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

public class Label: CustomStringConvertible, CustomDebugStringConvertible, JsonAble {
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
        return json
    }
    
    public var jsonContents: String {
        return "\"id\":\"" + key + "\",\"name\":\"" + name + "\",\"short\":\"" + short + "\""
    }
    
    public var json: String {
        return "{\(jsonContents)}"
    }
    
    

    // MARK: Initializers
    public required init() {
    }
    
    public init(key:String, name:String, short:String) {
        self.key = key
        self.name = name
        self.short = short
    }
    
    public required init(data:JSON) {
        if let key = data["key"].asString {
            self.key = key
            if let name = data["name"].asString {
                self.name = name
            } else {
                self.name = key
            }
            self.short = data["short"].asString ?? name
        } else {
            self.key = "ERROR"
            self.name = data["name"].asString ?? ""
            self.short = data["short"].asString ?? ""
        }
    }
    
    // MARK: Methods
}