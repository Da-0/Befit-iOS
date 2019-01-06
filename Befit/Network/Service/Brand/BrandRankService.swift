//
//  BrandRankService.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct BrandRankService: APIManager, Requestable{
    
    typealias NetworkData = ResponseArray<Brand>
    static let shared = BrandRankService()
    
    let URL = url("/brands/preference")
    
    let headers: HTTPHeaders = [
        "Authorization" : UserDefaults.standard.string(forKey: "token")!
    ]
    
    //브랜드 랭킹보여주기(10개) api
    func showBrandRank(completion: @escaping ([Brand]) -> Void) {
        
        gettable(URL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value.data!)
            case .error(let error):
                print(error)
            }
        }
        
    }

    
}
