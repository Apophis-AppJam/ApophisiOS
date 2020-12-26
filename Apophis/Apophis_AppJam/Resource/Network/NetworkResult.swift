//
//  NetworkResult.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/26.
//

import Foundation


enum NetworkResult<T> {
    case success(T,T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
