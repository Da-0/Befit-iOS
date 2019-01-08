//
//  UserInfoService.swift
//  Befit
//
//  Created by 이충신 on 08/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
// 회원조회를 하기 위한 서비스(통합회원정보관리, 초기화면에서 이용)

import Alamofire

struct UserInfoService: APIManager, Requestable{
    
    typealias NetworkData = ResponseObject<User>
    static let shared = UserInfoService()
    
    let URL = url("/user")
    
    let headers: HTTPHeaders = [
        "Authorization" : UserDefaults.standard.string(forKey: "token")!
    ]
    
    //개인 회원 정보 보여주기
    func showUserInfo(completion: @escaping (User) -> Void) {
        
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
