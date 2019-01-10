//
//  UnLikeService.swift
//  Befit
//
//  Created by 이충신 on 11/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct UnLikeBService: APIManager, Requestable{
    
    let userDefault = UserDefaults.standard
    typealias NetworkData = ResponseObject<Token>
    static let shared = UnLikeBService()
    
    let baseURL = url("/likes/brands/")

    //브랜드 좋아요 취소
    func unlike(brandIdx: Int, completion: @escaping (NetworkData) -> Void) {
        
        let url = baseURL + "\(brandIdx)"
        guard let token = userDefault.string(forKey: "token") else {return}
        
        let headers: HTTPHeaders = [
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
