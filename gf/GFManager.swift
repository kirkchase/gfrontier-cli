//
//  GFApplication.swift
//  gf
//
//  Created by KChase on 10/12/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

public class GFManager {
    // MARK: Properties
    static let sharedInstance = GFManager()
    
    var tags = [String: CardTag]()
    var durations = [String: CardDuration]()
    var usages = [String: CardUsage]()
    var cardTypes = [String: CardType]()
    var actionTypes = [String: CardActionType]()
    
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
        if !data["Card"].isNull {
            for index in 0..<data["Card"].length {
                let card = Card(data: data["Card"][index])
                print(card.json)
            }
        }
    }
    
    private func loadConstants(data:JSON) {
       if !data["CardTag"].isNull {
            tags.removeAll()
            for index in 0..<data["CardTag"].asArray!.count {
                let tag = CardTag(data: data["CardTag"][index])
                tags[tag.key] = tag
            }
        }
        if !data["CardDuration"].isNull {
            durations.removeAll()
            for index in 0..<data["CardDuration"].length {
                let turns = CardDuration(data: data["CardDuration"][index])
                durations[turns.key] = turns
            }
        }
        if !data["CardUsage"].isNull {
            usages.removeAll()
            for index in 0..<data["CardUsage"].length {
                let uses = CardUsage(data: data["CardUsage"][index])
                usages[uses.key] = uses
            }
        }
        if !data["CardType"].isNull {
            cardTypes.removeAll()
            for index in 0..<data["CardType"].length {
                let types = CardType(data: data["CardType"][index])
                cardTypes[types.key] = types
            }
        }
        if !data["CardActionType"].isNull {
            actionTypes.removeAll()
            for index in 0..<data["CardActionType"].length {
                let types = CardActionType(data: data["CardActionType"][index])
                actionTypes[types.key] = types
            }
        }
    }
    
}