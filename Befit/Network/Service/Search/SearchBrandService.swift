//
//  SearchBrandService.swift
//  Befit
//
//  Created by 박다영 on 10/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire

struct SearchBrandService: APIManager, Requestable{
    
    let userDefault = UserDefaults.standard
    typealias NetworkData = ResponseArray<Brand>
    static let shared = SearchBrandService()
    
    let baseURL = url("/search/brands")
    
    // 검색 후 브랜드
    func showSearchBrand(keyword: String, completion: @escaping (NetworkData) -> Void) {
        print("키워드값!!!!")
        print(keyword)
        guard let token = userDefault.string(forKey: "token") else {return}
        
        let URL = baseURL + "?name=" + (keyword.utf8EncodedString())
        
        let headers: HTTPHeaders = [
            "Authorization" : token
        ]
        
        gettable(URL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print("Error = \(error)")
            }
        }
        
    }
    
}
