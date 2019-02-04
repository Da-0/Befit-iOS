//
//  RemoveClosetService.swift
//  Befit
//
//  Created by 이충신 on 03/02/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct RemoveClosetService: APIManager, Requestable{
    
    let userDefault = UserDefaults.standard
    typealias NetworkData = ResponseObject<Token>
    static let shared = RemoveClosetService()
    
    let baseURL = url("/closet/")
    
    //상품 좋아요 취소
    func removeCloset(closetIdx: [Int], completion: @escaping (NetworkData) -> Void) {
        
        var realString = ""
        for (idx, val) in closetIdx.enumerated(){
            if idx == 0 { realString += "\(val)"}
            else{ realString += ",\(val)"}
        }
        
        let url = baseURL + realString
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
