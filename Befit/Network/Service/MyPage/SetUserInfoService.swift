//
//  SetUserInfoService.swift
//  Befit
//
//  Created by 이충신 on 08/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct SetUserInfoService: APIManager, Requestable{
    
    typealias NetworkData = ResponseObject<Token>
    static let shared = SetUserInfoService()
    
    let URL = url("/user/combineForm")
    
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Authorization" : UserDefaults.standard.string(forKey: "token")!
    ]
    
    //개인 회원 정보 보여주기
    func setUserInfo(post: String, address: String, detail: String, phone: String, completion: @escaping (NetworkData) -> Void) {
        
        let body = [
            "post_number" : post,
            "home_address": address,
            "detail_address": detail,
            "phone": phone
        ]
        
        puttable(URL, body: body, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
}
