//
//  TinyHTTPResponseImpl.swift
//  HiLeiaDomain
//
//  Created by caozheng on 2022/8/19.
//

import Foundation

struct DataTinyHTTPResponse: TinyHTTPDecodable {
    
    let data: Data
    let resp: URLResponse?

    init(data: Data, resp: URLResponse?) throws {
        self.data = data
        self.resp = resp
    }
}

// 支持Decodable
struct DecodableTinyHTTPResponse<T: Decodable>: TinyHTTPDecodable {
    
    let response: T
    let resp: URLResponse?
    
    init(data: Data, resp: URLResponse?) throws {
        self.response = try JSONDecoder().decode(T.self, from: data)
        self.resp = resp
    }
}


