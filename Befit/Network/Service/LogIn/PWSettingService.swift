//
//  PWSettingService.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct PWSettingService: APIManager, Requestable{
    
    typealias NetworkData = ResponseObject<Token>
    static let shared = PWSettingService()
    
    let URL = url("/user")
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    //비밀번호 재설정 api
    func setPW(idx: Int, pw: String, completion: @escaping (String) -> Void) {
        
        let body = [
            "userIdx" : idx,
            "password" : pw
            ] as [String : Any]
        
        puttable(URL, body: body, header: headers) { res in
            switch res {
            case .success(let value):
                    completion(value.message!)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
    
}
