//
//  LikeBrandService.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct showLikeBListService: APIManager, Requestable{
    
    typealias NetworkData = ResponseArray<Brand>
    static let shared = showLikeBListService()
    
    let URL = url("/likes/brands")
    
    //좋아요한 브랜드 보여주기
    func showBrandLike(completion: @escaping (NetworkData) -> Void) {
        
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
