//
//  APIManager.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

protocol APIManager {}

extension APIManager {
    
    // http://를 명시해주지 않으면 1002 ERROR가 발생한다.
    static func url(_ path: String) -> String {
        return "http://befitapi.tk:8081" + path
    }
    func gsno(_ value : String?) -> String{
        return value ?? ""
    }
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
}
