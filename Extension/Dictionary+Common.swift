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
    
    func bool(for key: Key) -> Bool? {
        if let value = self[key] {
            if let result = value as? Bool {
                return result
            }
        }
        return nil
    }
    
    func dic(for key: Key) -> [String: Any]? {
        if let value = self[key] {
            if let result = value as? [String: Any] {
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
    
    func flatten(prefix: String = "") -> [String: Any] {
        guard let dictionary = self as? [String: Any] else { return [:]}
        
        var result: [String: Any] = [:]
        
        for (key, value) in dictionary {
            let newKey = prefix.isEmpty ? key : "\(prefix).\(key)"
            
            if let nestedDict = value as? [String: Any] {
                // 递归展开子字典
                let flattened = nestedDict.flatten(prefix: newKey)
                result.merge(flattened) { (_, new) in new }
            } else {
                result[newKey] = value
            }
        }

        return result
    }
}
