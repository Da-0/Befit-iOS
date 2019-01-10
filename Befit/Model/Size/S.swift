//
//  S.swift
//  Befit
//
//  Created by 이충신 on 07/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import ObjectMapper

struct S : Mappable {
    
    var size : CommonSize?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        size <- map["S"]
        
    }
    
}
