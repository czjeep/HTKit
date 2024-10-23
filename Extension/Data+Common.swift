//
//  Data+Common.swift
//  WuKongKit
//
//  Created by caozheng on 2024/10/15.
//

import Foundation

extension Data {
    
    func string() -> String? {
        return String(data: self, encoding: .utf8)
    }
    
    func json() -> Any? {
        do {
            let result = try JSONSerialization.jsonObject(with: self)
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    func jsonDecoder<T: Decodable>(to type: T.Type) -> T? {
        do {
            let result = try JSONDecoder().decode(T.self, from: self)
            return result
        } catch {
            print(error)
        }
        return nil
    }
}
