//
//  SizeCheckService.swift
//  Befit
//
//  Created by 이충신 on 11/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct SizeCheckService: APIManager, Requestable{
    
    let userDefault = UserDefaults.standard
    typealias NetworkData = ResponseObject<SizeCheck>
    static let shared = SizeCheckService()
    
    func showSizeCheck(closetIdx: Int? ,productIdx: Int?, productSize: String?, completion: @escaping (NetworkData) -> Void) {
        
        guard let closet = closetIdx else {return}
        guard let product = productIdx else {return}
        guard let size = productSize else {return}
        
        let queryURL = "/closet/" + "\(closet)" + "/compare/" + "\(product)" + "?product_size=" + size
        
        guard let token = userDefault.string(forKey: "token") else {return}
        
        let headers: HTTPHeaders = [
            "Authorization" : token
        ]
        
        
        gettable(queryURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
}

