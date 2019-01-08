//
//  ProductSelectService.swift
//  Befit
//
//  Created by 이충신 on 08/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct ProductSelectService: APIManager, Requestable{
    
    typealias NetworkData = ResponseArray<Closet>
    static let shared = ProductSelectService()
    
    let URL = url("/closet/brands/" + "\(UserDefaults.standard.integer(forKey: "brand_idx"))" + "/category/" + "\(UserDefaults.standard.integer(forKey: "category_idx"))")
    
    let headers: HTTPHeaders = [
        "Authorization" : UserDefaults.standard.string(forKey: "token")!
    ]
    
    //해당 카테고리의 등록된 상품 리스트 출력
    func showProductList(completion: @escaping ([Closet]?) -> Void) {
        print(URL)
        gettable(URL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value.data)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
}
