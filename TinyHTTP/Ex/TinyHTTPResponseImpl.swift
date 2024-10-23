//
//  TinyHTTPResponseImpl.swift
//  HiLeiaDomain
//
//  Created by caozheng on 2022/8/19.
//

import Foundation

struct DataTinyHTTPResponse: TinyHTTPDecodable {
    
    let data: Data

    init(data: Data) {
        self.data = data
    }
    
}

// 支持Decodable
struct DecodableTinyHTTPResponse<T: Decodable>: TinyHTTPDecodable {
    
    let response: T
    
    init(data: Data) throws {
        response = try JSONDecoder().decode(T.self, from: data)
    }
}


