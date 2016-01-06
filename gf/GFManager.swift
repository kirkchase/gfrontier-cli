//
//  GFApplication.swift
//  gf
//
//  Created by KChase on 10/12/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation
import AppKit

public class GFManager {
    // MARK: Properties
    static let sharedInstance = GFManager()
    
    var tags = [String: CardTag]()
    var usages = [String: CardUsage]()
    var effectRanges = [String: EffectRange]()
    var cardTypes = [String: CardType]()
    var actionTypes = [String: CardActionType]()
    var textConstants = [String: Label]()
    public var cardTemplates = [String: Card]()
    
    // MARK: Initializers
    public init() {
        
    }
    
    // MARK: Methods
    public func load(data:JSON) {
        if data.isError {
            print("Parse error")
            return
        }
        
        loadConstants(data)
        if !data["Card"].isError {
            for index in 0..<data["Card"].length {
                let card = Card(data: data["Card"][index])
                cardTemplates[card.key] = card
            }
        }
    }
    
    private func loadConstants(data:JSON) {
       if !data["CardTag"].isError {
            for index in 0..<data["CardTag"].asArray!.count {
                let tag = CardTag(data: data["CardTag"][index])
                tags[tag.key] = tag
            }
        }
        if !data["CardUsage"].isError {
            for index in 0..<data["CardUsage"].length {
                let uses = CardUsage(data: data["CardUsage"][index])
                usages[uses.key] = uses
                textConstants[uses.key] = uses
            }
        }
        if !data["EffectRange"].isError {
            for index in 0..<data["EffectRange"].length {
                let uses = EffectRange(data: data["EffectRange"][index])
                effectRanges[uses.key] = uses
                textConstants[uses.key] = uses
            }
        }
        if !data["CardType"].isError {
            for index in 0..<data["CardType"].length {
                let types = CardType(data: data["CardType"][index])
                cardTypes[types.key] = types
                textConstants[types.key] = types
            }
        }
        if !data["CardActionType"].isError {
            for index in 0..<data["CardActionType"].length {
                let types = CardActionType(data: data["CardActionType"][index])
                actionTypes[types.key] = types
                textConstants[types.key] = types
            }
        }
        if !data["Constants"].isError {
            for index in 0..<data["Constants"].length {
                let types = Label(data: data["Constants"][index])
                textConstants[types.key] = types
            }
        }
    }
    
    public func replaceTokens(value : String) -> String {
        var output = ""
        let tokens = value.componentsSeparatedByString("{")
        for token in tokens {
            let subtoken = token.componentsSeparatedByString("}")
            if subtoken.count < 2 {
                output += token
            } else {
                if let str = textConstants[subtoken[0]] {
                    output += str.short + subtoken[1]
                } else {
                    output += "{" + subtoken[0] + "}" + subtoken[1]
                }
                
            }
        }
        
        return output;
    }
}