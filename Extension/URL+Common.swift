//
//  URL+Common.swift
//  HiLeia.PS
//
//  Created by caozheng on 2022/10/18.
//

import Foundation

extension URL {
    
    func getHost() -> String? {
        let host: String?
        if #available(iOS 16.0, *) {
            host = self.host()
        } else {
            host = self.host
        }
        
        return host
    }
    
    func getURLParam() -> [String] {
        let query: String?
        if #available(iOS 16.0, *) {
            query = self.query()
        } else {
            query = self.query
        }
        
        let param = query?.components(separatedBy: "&") ?? []
        return param
    }
    
}
