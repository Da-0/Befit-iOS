//
//  GetClosetDetailService.swift
//  Befit
//
//  Created by 이충신 on 09/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct GetClosetDetailService: APIManager, Requestable{
    
    typealias NetworkData = ResponseObject<Closet>
    static let shared = GetClosetDetailService()
    
    let URL = url("/closet/")
    
    let headers: HTTPHeaders = [
        "Authorization" : UserDefaults.standard.string(forKey: "token")!
    ]
    
    //해당 카테고리의 등록된 옷의 세부 정보
    func showClosetDetail(idx: Int , completion: @escaping (NetworkData) -> Void) {
        
        let url = URL + "\(idx)"
        
        gettable(url, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
}
