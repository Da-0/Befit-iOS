//
//  ResponseArray.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import ObjectMapper

struct ResponseArray<T: Mappable>: Mappable {
    
    var status: Int?
    var message: String?
    var data: [T]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
}
