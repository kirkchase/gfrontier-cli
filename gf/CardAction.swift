//
//  CardAction.swift
//  gf
//
//  Created by KChase on 10/12/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

public class CardAction: CustomStringConvertible, CustomDebugStringConvertible, JsonAble {
    var type = Empty_CardActionType
    var title = ""; // something in bold
    var instructions = ""
    var usage = CardUsage()
    var used : Int = 0
    var usedInTurn : Bool = false
    var attributes = [CardAttribute]()
    
    // MARK: Computed Properties
    public var description: String {
        var working = type.short
        if title.length > 0 {
            working += title + ". "
        }
        working += instructions
        return "\(working)"
    }
    
    public var debugDescription: String {
        return json
    }

    public required init(data:JSON) {
        self.type = GFManager.sharedInstance.actionTypes[data["type"].asString ?? "ActionOpen"] ?? GFManager.sharedInstance.actionTypes["ActionOpen"]!
        self.title = data["title"].asString ?? ""
        self.instructions = data["instructions"].asString ?? ""
        self.usage = GFManager.sharedInstance.usages[data["usage"].asString ?? "Game"] ?? GFManager.sharedInstance.usages["Game"]!
        self.used = data["used"].asInt ?? 0
        self.usedInTurn = data["usedInTurn"].asBool ?? false
        attributes.removeAll()
        // look for attributes
        if !data["attributes"].isNull {
            for index in 0..<data["attributes"].length {
                let attribute = CardAttribute(data: data["attributes"][index])
                attributes += [attribute]
            }
        }
    }
    
    public init() {
    }

    public var jsonContents: String {
        var working = "\"type\":\"" + type.key + "\""
        if title.length > 0 {
            working += ",\"title\":\"" + title + "\""
        }
        working += ",\"instructions\":\"" + instructions + "\""
        working += ",\"usage\":\"" + usage.key + "\""
        working += ",\"usage\":\"" + usage.key + "\""
        working += ",\"used\":" + String(used)
        working += ",\"usedInTurn\":" + String(usedInTurn)

        // get attribute contents
        if attributes.count > 0 {
            working += "\"attributes\":["
            var i = 1;
            for attribute in attributes {
                working += attribute.json
                if i < attributes.count {
                    working += ","
                }
                i++;
            }
            working += "]"
        }
        
        return working
    }
    
    public var json: String {
        return "{" + jsonContents + "}"
    }

}