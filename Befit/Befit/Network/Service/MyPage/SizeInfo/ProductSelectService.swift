//
//  ProductSelectService.swift
//  Befit
//
//  Created by 이충신 on 08/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct ProductSelectService: APIManager, Requestable{
    
    let userdefault = UserDefaults.standard
    typealias NetworkData = ResponseArray<Product>
    static let shared = ProductSelectService()
    
    let URL = url("/closet/brands/")
    
    //해당 카테고리의 등록된 상품 리스트 출력
    func showProductList(brandIdx: Int, categoryIdx: Int, completion: @escaping ([Product]?) -> Void) {
        
        guard let token = userdefault.string(forKey: "token") else {return}
        
        let headers: HTTPHeaders = [
            "Authorization" : token
        ]
        
        
        let url = URL + "\(brandIdx)" + "/category/" + "\(categoryIdx)"
        
        print("spl = \(url)")
        
        gettable(url, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value.data)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
}
