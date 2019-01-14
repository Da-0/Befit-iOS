//
//  Idx.swift
//  Befit
//
//  Created by 이충신 on 14/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
import ObjectMapper

struct Idx: Mappable {
    
    var idx: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        idx <- map["idx"]
    }
}

