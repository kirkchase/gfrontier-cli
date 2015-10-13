//
//  CardAction.swift
//  gf
//
//  Created by KChase on 10/12/15.
//  Copyright © 2015 Kirk Chase. All rights reserved.
//

import Foundation

public class CardAction: Label {
    var attributes = [CardAttribute]()
    
    public required init(data:JSON) {
        super.init(data: data)
        attributes.removeAll()
        // look for attributes
        if !data["attributes"].isNull {
            for index in 0..<data["attributes"].length {
                let attribute = CardAttribute(data: data["attributes"][index])
                attributes += [attribute]
            }
        }
    }
    
    public required init() {
        super.init()
    }

    override public var jsonContents: String {
        var working = super.jsonContents
        // get attribute contents
        if attributes.count > 0 {
            working += "\"attributes\":["
            var i = 1;
            for attribute in attributes {
                working + attribute.json
                if i < attributes.count {
                    working += ","
                }
                i++;
            }
            working += "]"
        }
        
        return working
    }

}