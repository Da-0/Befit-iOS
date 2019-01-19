//
//  LikePService.swift
//  Befit
//
//  Created by 이충신 on 11/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct LikePService: APIManager, Requestable{
    
    let userDefault = UserDefaults.standard
    typealias NetworkData = ResponseObject<Token>
    static let shared = LikePService()
    
    let baseURL = url("/likes/products/")
    
    //상품 좋아요
    func like(productIdx: Int, completion: @escaping (NetworkData) -> Void) {
        
        let url = baseURL + "\(productIdx)"
        guard let token = userDefault.string(forKey: "token") else {return}
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization" : token
        ]
        
        
        postable(url, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    //상품 좋아요 취소
    func unlike(productIdx: Int, completion: @escaping (NetworkData) -> Void) {
        
        let url = baseURL + "\(productIdx)"
        guard let token = userDefault.string(forKey: "token") else {return}
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization" : token
        ]
        
        
        delete(url, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
    
}
