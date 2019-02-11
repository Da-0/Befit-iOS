//
//  SearchFirstService.swift
//  Befit
//
//  Created by 이충신 on 07/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct SearchFirstService: APIManager, Requestable{
    
    typealias NetworkData = ResponseArray<Product>
    static let shared = SearchFirstService()
    
    let URL = url("/search/firstSearchPage")
    

    
    //검색 첫화면 추천(24개)상품 보여주기
    func showSearchFirstView(completion: @escaping ([Product]) -> Void) {
        
        let headers: HTTPHeaders = [
            "Authorization" : UserDefaults.standard.string(forKey: "token")!
        ]
        
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
