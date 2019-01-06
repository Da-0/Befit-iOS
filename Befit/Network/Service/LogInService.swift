//
//  LogInService.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct LoginService: APIManager, Requestable {
    
    typealias NetworkData = ResponseObject<Token>
    static let shared = LoginService()
    
    let loginURL = url("/login")
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    //로그인 api
    func login(email: String, password: String, completion: @escaping (Token) -> Void) {
        
        let body = [
            "email" : email,
            "password" : password
            ]
        
        postable(loginURL, body: body, header: headers) { res in
            switch res {
            case .success(let value):
                guard let token = value.data else {return}
                completion(token)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
    
}
