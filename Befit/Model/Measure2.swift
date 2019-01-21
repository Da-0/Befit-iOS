//
//  Measure2.swift
//  Befit
//
//  Created by 이충신 on 07/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
// MySize에서 받는 용도의 Measure type

import Foundation
import ObjectMapper

struct Measure2 : Mappable {
    
    var total: String?
    var chest : String?
    var sleeve : String?
    var shoulder : String?
    
    var waist: String?
    var thigh: String?
    var crotch: String?
    var dobla: String?
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        total <- map["totalLength"]
        chest <- map["chestSection"]
        sleeve <- map["sleeveLength"]
        shoulder <- map["shoulderWidth"]
        
        waist <- map["waistSection"]
        thigh <- map["thighSection"]
        crotch <- map["crotch"]
        dobla <- map["dobladillosSection"]
    }
    
}


