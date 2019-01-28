//
//  SizeCheck.swift
//  Befit
//
//  Created by 이충신 on 23/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import ObjectMapper

struct SizeCheck : Mappable {
    
    var measure: Measure2?
    var percent: String?
    var my_url: String?
    var compare_url: String?
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        measure <- map["measure"]
        percent <- map["percent"]
        my_url <- map["my_url"]
        compare_url <- map["compare_url"]
    }
    
}





