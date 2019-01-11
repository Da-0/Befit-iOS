//
//  XL.swift
//  Befit
//
//  Created by 이충신 on 11/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import ObjectMapper

struct XL : Mappable {
    
    var size : CommonSize?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        size <- map["XL"]
        
    }
    
}
