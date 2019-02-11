//
//  showLikePListService.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct showLikePListService: APIManager, Requestable{
    
    typealias NetworkData = ResponseArray<Product>
    static let shared = showLikePListService()
    
    let URL = url("/likes/products")

    //좋아요한 상품 보여주기
    func showProductLike(completion: @escaping (NetworkData) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization" : UserDefaults.standard.string(forKey: "token")!
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
