//
//  BrandRank.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import ObjectMapper

struct BrandRank : Mappable {
    
    var idx : Int?
    var name_korean : String?
    var name_english : String?
    var gender : String?
    var style1 : String?
    var style2 : String?
    var like_score : Int?
    var link : String?
    var logo_url : String?
    var mainpage_url : String?
    var mainfeed_url : String?
    var likeFlag : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        idx <- map["idx"]
        name_korean <- map["name_korean"]
        name_english <- map["name_english"]
        gender <- map["gender"]
        style1 <- map["style1"]
        style2 <- map["style2"]
        like_score <- map["like_score"]
        link <- map["link"]
        logo_url <- map["logo_url"]
        mainpage_url <- map["mainpage_url"]
        mainfeed_url <- map["mainfeed_url"]
        likeFlag <- map["likeFlag"]
    }
    
}
