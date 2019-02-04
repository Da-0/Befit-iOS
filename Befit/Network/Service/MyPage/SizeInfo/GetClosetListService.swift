//
//  GetClosetListService.swift
//  Befit
//
//  Created by 이충신 on 08/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//


import Alamofire

struct GetClosetListService: APIManager, Requestable{
    
    let userDefault = UserDefaults.standard
    typealias NetworkData = ResponseArray<Closet>
    static let shared = GetClosetListService()
    
    let URL = url("/closet/category/")
    

    //해당 카테고리의 등록된 옷 리스트 출력
    func showClosetList(idx: Int, completion: @escaping (NetworkData) -> Void) {
        
        guard let token = userDefault.string(forKey: "token") else {return}
        
        let headers: HTTPHeaders = [
                "Authorization" : token
            ]
        
        let url = URL + "\(idx)"
        
        gettable(url, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                print("현재 옷장 리스트 출력")
                print(value.data)
                completion(value)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
}
