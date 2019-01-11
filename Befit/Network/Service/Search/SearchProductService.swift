//
//  SearchProductNewService.swift
//  Befit
//
//  Created by 박다영 on 09/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire

struct SearchProductService: APIManager, Requestable{
    
    let userDefault = UserDefaults.standard
    typealias NetworkData = ResponseArray<Product>
    static let shared = SearchProductService()
    
    let baseURL = url("/search/products")
    
    // 검색 후 신상품순
    func showSearchProductNew(keyword: String, completion: @escaping (NetworkData) -> Void) {
        print("키워드값!!!!")
        print(keyword)
        guard let token = userDefault.string(forKey: "token") else {return}
        
        let URL = baseURL + "/new?name=" + (keyword.utf8EncodedString())
        
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
    
     //검색 후 인기순
    func showSearchProductPopular(keyword: String, completion: @escaping (NetworkData) -> Void) {
        
        guard let token = userDefault.string(forKey: "token") else {return}
        let testkeyword = keyword.utf8
        
        print("아아아아ㅏㅇ아아아ㅏ아앙\(keyword)")
        print("아아아아ㅏㅇ아아아ㅏ아앙\(testkeyword)")
        let URL = baseURL + "/popular" + "?name=" + (keyword.utf8EncodedString())
        
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
