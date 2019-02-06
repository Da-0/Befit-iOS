//
//  BrandRank.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import ObjectMapper

struct Brand : Mappable {
    
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
    var brandLike: Int?
    var likeFlag : Int?
    var products: [Product]?
    
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
        brandLike <- map["brand_like"]
        likeFlag <- map["likeFlag"]
        products <- map["products"]
        
        
    }
    
}

enum BrandName: Int {
    case THISISNEVERTHAT = 17
    case ROMANTIC_CROWN = 12
    case IST_KUNST = 18
    case LIBERTENG = 10
    case COVERNAT = 7
    case ANDERSSON = 9
    case INSILENCE = 22
    case CRITIC = 14
    case MINAV = 2
    case LAFUDGESTORE = 3
    case MORE_OR_LESS = 32
    case OiOi = 37
}

//남,여 Tag 번호에 따른 실제 브랜드 Idx

//남성:
//0. THISISNEVERTHAT 17.
//1. ROMANTIC CROWN 12
//2. IST KUNST 18
//3. LIBERTENG 10
//4. COVERNAT 7
//5. ANDERSSON BELL 9
//6. INSILENCE 22
//7. CRITIC 14

//여성:
//0. THISISNEVERTHAT 17
//1. ROMANTIC CROWN 12
//2. MINAV 2    ***************
//3. LAFUDGESTORE 3   ***************
//4. MORE OR LESS 32   ***************
//5. ANDERSSON BELL 9
//6. OiOi 37     ***************
//7. CRITIC 14
