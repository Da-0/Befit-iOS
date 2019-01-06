//
//  NetworkResult.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

enum NetworkResult<T> {
    case success(T)
    case error(Error)
}
