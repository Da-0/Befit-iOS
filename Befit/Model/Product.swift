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
    var measure : Measure?
    var like_score : Int?
    var product_like : Int?
    var brand_Korean_name : String?
    
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
        measure <- map["measure"]
        like_score <- map["like_score"]
        product_like <- map["product_like"]
        brand_Korean_name <- map["brand_Korean_name"]
    }
    
}
