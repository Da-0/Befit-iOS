//
//  AddClosetService.swift
//  Befit
//
//  Created by 이충신 on 09/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct AddClosetService: APIManager, Requestable {
    
    typealias NetworkData = ResponseObject<Token>
    static let shared = AddClosetService()
    
    let URL = url("/closet")
    
  
    
    //옷장 추가 api
    func addCloset(idx: Int, size: String, completion: @escaping (NetworkData) -> Void) {
        
        let body = [
            "product_idx" : idx,
            "product_size" : size
            ] as [String : Any]
    
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Authorization" : UserDefaults.standard.string(forKey: "token")!
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
