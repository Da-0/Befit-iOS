//
//  CommonSize.swift
//  Befit
//
//  Created by 이충신 on 09/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import ObjectMapper

struct CommonSize <T: Mappable>: Mappable {
    
    var commonSize: T?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        commonSize <- map["commonSize"]
    }
}

//struct CommonSize : Mappable {
//
//    var total : String?
//    var chest : String?
//    var sleeve : String?
//    var shoulder : String?
//    var waist: String?
//    var thigh: String?
//    var crotch: String?
//    var dobla: String?
//
//    var dictionary: [String: String?] {
//
//        return ["totalLength": total,
//                "chestSection": chest,
//                "sleeveLength": sleeve,
//                "shoulderWidth": shoulder,
//                "waistSection" : waist,
//                "thighSection" : thigh,
//                "crotch" : crotch,
//                "dobladillosSection" : dobla
//        ]
//    }
//
//    init?(map: Map) {
//    }
//
//    mutating func mapping(map: Map) {
//
//        total <- map["totalLength"]
//        chest <- map["chestSection"]
//        sleeve <- map["sleeveLength"]
//        shoulder <- map["shoulderWidth"]
//
//        waist <- map["waistSection"]
//        thigh <- map["thighSection"]
//        crotch <- map["crotch"]
//        dobla <- map["dobladillosSection"]
//
//
//    }
//
//}



    //1)후드티, 맨투맨, 아우터, 원피스, 티셔츠, 셔츠, 코트 적용
    //총장, 어깨 너비, 가슴 단면, 소매 길이
    //[totalLength,
    //shoulderWidth,
    //chestSection,
    //sleeveLength
    //]
    //
    //
    //2)베스트(조끼) 적용
    //총장, 어깨 너비, 가슴 단면
    //[totalLength,
    //shoulderWidth,
    //chestSection]
    //
    //3)진, 슬랙스, 반바지, 레깅스 적용
    //총장, 허리 단면, 허벅지 단면, 밑위, 밑단 단면
    //[totalLength,
    //waistSection,
    //thighSection,
    //crotch,
    //dobladillosSection]
    //
    //
    //4)스커트 적용
    //총장, 허리 단면, 밑단 단면
    //[totalLength,
    //waistSection,
    //dobladillosSection]
