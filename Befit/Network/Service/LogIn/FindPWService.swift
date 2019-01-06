//
//  FindPWService.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct FindPWService: APIManager, Requestable{
    
    typealias NetworkData = ResponseObject<Idx>
    static let shared = FindPWService()
    
    let URL = url("/user/passwordFind")
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    //비밀번호 찾기 api
    func findPW(email: String, name: String, birthday: String, completion: @escaping (NetworkData) -> Void) {
        
        let body = [
            "email" : email,
            "name" : name,
            "birthday" : birthday
        ]
        
        postable(URL, body: body, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
    
}
