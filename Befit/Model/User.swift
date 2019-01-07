//
//  User.swift
//  Befit
//
//  Created by 이충신 on 08/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import ObjectMapper

struct User : Mappable {
    
    var idx : Int?
    var email : String?
    var password : String?
    var gender : String?
    var name : String?
    var brand1_idx : Int?
    var brand2_idx : Int?
    var height : Int?
    var weight : Int?
    var birthday : String?
    var phone : String?
    var post_number : String?
    var home_address : String?
    var detail_address : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        idx <- map["idx"]
        email <- map["email"]
        password <- map["password"]
        gender <- map["gender"]
        name <- map["name"]
        brand1_idx <- map["brand1_idx"]
        brand2_idx <- map["brand2_idx"]
        height <- map["height"]
        weight <- map["weight"]
        birthday <- map["birthday"]
        phone <- map["phone"]
        post_number <- map["post_number"]
        home_address <- map["home_address"]
        detail_address <- map["detail_address"]
    }
    
}
