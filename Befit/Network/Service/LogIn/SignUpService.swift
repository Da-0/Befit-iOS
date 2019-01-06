//
//  SignUpService.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct SignUpService: APIManager, Requestable{
    
    typealias NetworkData = ResponseObject<Token>
    static let shared = SignUpService()
    
    let URL = url("/user")
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    //회원가입 api
    func signUp(email: String, pw: String, gender: String, name: String, brand1: Int, brand2: Int, birthday: String, completion: @escaping (String) -> Void) {
        
        let body = [
            "email" : email,
            "password" : pw,
            "gender" : gender,
            "name" : name,
            "brand1_idx": brand1,
            "brand2_idx": brand2,
            "birthday": birthday
            ] as [String : Any]
        
        postable(URL, body: body, header: headers) { res in
            switch res {
            case .success(let value):
               completion(value.message!)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
    
}