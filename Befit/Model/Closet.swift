//
//  Closet.swift
//  Befit
//
//  Created by 이충신 on 08/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import ObjectMapper

struct Closet : Mappable {
    
    var closet_idx : Int?
    var name_korean : String?
    var name_english : String?
    var name : String?
    var image_url : String?
    var product_category_index : Int?
    var product_size : String?
    var measure : Measure?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        closet_idx <- map["closet_idx"]
        name_korean <- map["name_korean"]
        name_english <- map["name_english"]
        name <- map["name"]
        image_url <- map["image_url"]
        product_category_index <- map["product_category_index"]
        product_size <- map["product_size"]
        measure <- map["measure"]
    }
    
}
