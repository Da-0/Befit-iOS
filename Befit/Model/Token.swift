//
//  Token.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import ObjectMapper

struct Token: Mappable {
    
    var token: String?

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        token <- map["token"]
    }
}

