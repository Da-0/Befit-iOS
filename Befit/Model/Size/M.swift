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
    
//    var size : CommonSize?
    var total : String?
    var chest : String?
    var sleeve : String?
    var shoulder : String?
    var waist: String?
    var thigh: String?
    var crotch: String?
    var dobla: String?
    init?(map: Map) {
    }
    
    var dictionary: [String: String?] {
        
        return ["totalLength": total,
                "chestSection": chest,
                "sleeveLength": sleeve,
                "shoulderWidth": shoulder,
                "waistSection" : waist,
                "thighSection" : thigh,
                "crotch" : crotch,
                "dobladillosSection" : dobla
        ]
    }
    mutating func mapping(map: Map) {
        
//        size <- map["M"]
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
