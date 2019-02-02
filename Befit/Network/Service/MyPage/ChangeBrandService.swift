//
//  ChangeBrandService.swift
//  Befit
//
//  Created by 이충신 on 08/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct ChangeBrandService: APIManager, Requestable{
    
    typealias NetworkData = ResponseObject<Token>
    static let shared = ChangeBrandService()
    
    let URL = url("/user/brand")
   
    
    //비밀번호 재설정 api
    func setBrand(brand1: Int, brand2: Int, completion: @escaping (NetworkData) -> Void) {
        
        let body = [
            "brand1_idx" : brand1,
            "brand2_idx" : brand2
            ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Authorization": UserDefaults.standard.string(forKey: "token")!
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
