//
//  Measure.swift
//  Befit
//
//  Created by 이충신 on 07/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import ObjectMapper

struct Measure : Mappable {
    
    var large : L?
    var medium : M?
    var small : S?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        large <- map["L"]
        medium <- map["M"]
        small <- map["S"]
    }
    
}
