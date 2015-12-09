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
    var title = "" // something in bold
    var instructions = ""
    var range = Empty_EffectRange
    var turnwide = false
    var activated = false
    
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
        self.type = GFManager.sharedInstance.actionTypes[data["type"].asString ?? "ActionOpen"] ?? CardActionType(key: "Unknown CardActionType", name: "Unknown CardActionType", short: data["type"].asString!)
        self.title = data["title"].asString ?? ""
        self.instructions = data["instructions"].asString ?? ""
        self.range = GFManager.sharedInstance.effectRanges[data["range"].asString ?? "Character"] ?? EffectRange(key: "Unknown EffectRange", name: "Unknown CardActionType", short: data["range"].asString!)
        self.turnwide = data["turnwide"].asBool ?? false
        self.activated = data["activated"].asBool ?? false
    }
    
    public init() {
    }

    public var jsonContents: String {
        var working = "\"type\":\"" + type.key + "\""
        working += ",\"title\":\"" + title + "\""
        working += ",\"instructions\":\"" + instructions + "\""
        working += ",\"range\":\"" + range.key + "\""
        working += ",\"turnwide\":" + turnwide.description
        working += ",\"activated\":" + activated.description

        return working
    }
    
    public var json: String {
        return "{" + jsonContents + "}"
    }

}