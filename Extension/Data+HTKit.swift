//
//  Data+HTKit.swift
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
    
    /// 回抛出异常
    func jsonDecoder2<T: Decodable>(to type: T.Type) throws -> T {
        let result = try JSONDecoder().decode(T.self, from: self)
        return result
    }
    
    func jsonDic() -> [String: Any] {
        guard let obj = json() as? [String: Any] else {
            return [:]
        }
        return obj
    }
}

extension Data {
    
    var hexLower: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
    
    var base64: String {
        return base64EncodedString()
    }
}

