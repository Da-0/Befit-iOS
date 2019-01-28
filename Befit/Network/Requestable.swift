//
//  Requestable.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

protocol Requestable {
    associatedtype NetworkData: Mappable
}

extension Requestable {
    
    func gettable(_ url: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        
        Alamofire.request(url, method: .get, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject { (res: DataResponse<NetworkData>) in
            switch res.result {
            case .success:
                guard let value = res.result.value else { return }
                completion(.success(value))
            case .failure(let err):
                completion(.error(err))
            }
        }
        
    }
    
    func gettableSync(_ url: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        
        Alamofire.request(url, method: .get, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject { (res: DataResponse<NetworkData>) in
            
            switch res.result {
                case .success:
                    guard let value = res.result.value else { return }
                    completion(.success(value))
                case .failure(let err):
                    completion(.error(err))
            }
            
            
        }
        
    }
    
    func postable(_ url: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject { (res: DataResponse<NetworkData>) in
            switch res.result {
            case .success:
                guard let value = res.result.value else { return }
                completion(.success(value))
            case .failure(let err):
                completion(.error(err))
            }
            
        }
    }
    
    func puttable(_ url: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        
        Alamofire.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject { (res: DataResponse<NetworkData>) in
            switch res.result {
            case .success:
                guard let value = res.result.value else { return }
                completion(.success(value))
            case .failure(let err):
                completion(.error(err))
            }
            
        }
    }
    
    func delete(_ url: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        
        Alamofire.request(url, method: .delete, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject { (res: DataResponse<NetworkData>) in
            switch res.result {
            case .success:
                guard let value = res.result.value else { return }
                completion(.success(value))
            case .failure(let err):
                completion(.error(err))
            }
            
        }
    }
}
