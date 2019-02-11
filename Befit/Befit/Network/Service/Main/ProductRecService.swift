//
//  ProductRecService.swift
//  Befit
//
//  Created by 이충신 on 10/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct ProductRecService: APIManager, Requestable {
    
    let userDefault = UserDefaults.standard
    typealias NetworkData = ResponseArray<Product>
    static let shared = ProductRecService()
    
    let URL = url("/products/forUserRec")
    

    func showProductRec(completion: @escaping (NetworkData) -> Void) {
    
        guard let token = userDefault.string(forKey: "token") else {return}
        
        let headers: HTTPHeaders = [
           "Authorization" : token
        ]
        
        gettable(URL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
    
}
