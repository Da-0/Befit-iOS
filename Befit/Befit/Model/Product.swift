//
//  Product.swift
//  Befit
//
//  Created by 이충신 on 07/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import ObjectMapper

struct Product : Mappable {
    
    var idx : Int?
    var name : String?
    var price : String?
    var image_url : String?
    var product_category_index : Int?
    var brand_idx : Int?
    var date : String?
    var link : String?
    var measure1 : Measure1?
    var like_score : Int?
    var product_like : Int?
    var name_korean : String?
    var name_English: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        idx <- map["idx"]
        name <- map["name"]
        price <- map["price"]
        image_url <- map["image_url"]
        product_category_index <- map["product_category_index"]
        brand_idx <- map["brand_idx"]
        date <- map["date"]
        link <- map["link"]
        measure1 <- map["measure"]
        like_score <- map["like_score"]
        product_like <- map["product_like"]
        name_korean <- map["name_korean"]
        name_English <- map["name_english"]
        
    }
    
}


