//
//  M.swift
//  Befit
//
//  Created by 이충신 on 07/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
import Foundation
import ObjectMapper

struct M : Mappable {
    
    var total : String?
    var chest : String?
    var sleeve : String?
    var shoulder : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        total <- map["총장"]
        chest <- map["가슴단면"]
        sleeve <- map["소매길이"]
        shoulder <- map["어깨너비"]
    }
    
}
