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
    
    // MARK: Initializers
    public init() {
        
    }
    
    // MARK: Methods
    public func load(data:JSON) {
        // load constants
        if !data["CardTag"].isNull {
            tags.removeAll()
            for index in 0..<data["CardTag"].length {
                let label = CardTag(data: data["CardTag"][index])
                tags[label.key] = label
            }
        }
        if !data["CardDuration"].isNull {
            durations.removeAll()
            for index in 0..<data["CardDuration"].length {
                let label = CardDuration(data: data["CardDuration"][index])
                durations[label.key] = label
            }
        }
        if !data["CardUsage"].isNull {
            usages.removeAll()
            for index in 0..<data["CardUsage"].length {
                let label = CardUsage(data: data["CardUsage"][index])
                usages[label.key] = label
            }
        }
        if !data["CardType"].isNull {
            usages.removeAll()
            for index in 0..<data["CardType"].length {
                let label = CardType(data: data["CardType"][index])
                cardTypes[label.key] = label
            }
        }
    }
    
}