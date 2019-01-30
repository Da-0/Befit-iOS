//
//  Measure2.swift
//  Befit
//
//  Created by 이충신 on 07/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  MySize에서 데이터를 받는 Measure type

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

enum BodyPart: String {
    
    case chest = "가슴 단면"
    case total = "총장"
    case shoulder = "어깨 너비"
    case sleeve = "소매 길이"
    
    case waist = "허리 단면"
    case thigh = "허벅지 단면"
    case crotch = "밑위"
    case dobla = "밑단 단면"
    
}


