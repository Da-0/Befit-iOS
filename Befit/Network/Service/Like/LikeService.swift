//
//  LikeService.swift
//  Befit
//
//  Created by 이충신 on 11/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct LikeService: APIManager, Requestable{
    
    typealias NetworkData = ResponseArray<Product>
    static let shared = LikeService()
    
    let URL = url("/likes/products")
    
    let headers: HTTPHeaders = [
        "Authorization" : UserDefaults.standard.string(forKey: "token")!
    ]
    
    //좋아요한 상품 보여주기
    func like(completion: @escaping ([Product]) -> Void) {
        
        gettable(URL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                guard let data = value.data else {return}
                completion(data)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
}
