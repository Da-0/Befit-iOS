//
//  BrandSelectService.swift
//  Befit
//
//  Created by 이충신 on 08/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct BrandSelectService: APIManager, Requestable{
    
    let userDefault = UserDefaults.standard
    typealias NetworkData = ResponseArray<Brand>
    static let shared = BrandSelectService()
    
    let URL = url("/brands")
    
    //이니셜로 검색하는 경우 브랜드 리스트를 출력 해주는 api
    func showBrandList(completion: @escaping ([Brand]?) -> Void) {
        
        guard let token = userDefault.string(forKey: "token") else {return}
        guard let brandInitial = userDefault.string(forKey: "brand_initial") else {return}
        
        let headers: HTTPHeaders = [
            "Authorization" : token
        ]
        
       let queryURL = URL + "?initial=" + brandInitial
    
        gettable(queryURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value.data)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
}
