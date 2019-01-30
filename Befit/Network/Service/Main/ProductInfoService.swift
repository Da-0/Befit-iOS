//
//  ProductInfoService.swift
//  Befit
//
//  Created by 이충신 on 30/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct ProductInfoService: APIManager, Requestable {
    
    let userDefault = UserDefaults.standard
    typealias NetworkData = ResponseObject<Product>
    static let shared = ProductInfoService()
    
    let URL = url("/products/")
    
    func showProductInfo(idx: Int, completion: @escaping (NetworkData) -> Void) {
        
        guard let token = userDefault.string(forKey: "token") else {return}
        
        let headers: HTTPHeaders = [
            "Authorization" : token
        ]
        let url = URL + "\(idx)"
        
        gettable(url, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
    
}
