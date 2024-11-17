//
//  Dictionary+Common.swift
//  WuKongKit
//
//  Created by caozheng on 2024/10/15.
//

import Foundation

extension Dictionary {
    
    var jsonString: String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self)
            return String(data: data, encoding: .utf8)
        } catch {
            print(error)
        }
        return nil
    }
    
    mutating func append(with dic:[Key:Value]) {
        for item in dic {
            self[item.key] = item.value
        }
    }
    
    func string(for key: Key) -> String? {
        if let value = self[key],
           let result = value as? String {
            return result
        }
        return nil
    }
    
    func int(for key: Key) -> Int? {
        if let value = self[key] {
            if let result = value as? Int {
                return result
            }
        }
        return nil
    }
    
    var jsonData: Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self)
            return data
        } catch {
            print(error)
        }
        return nil
    }
}
