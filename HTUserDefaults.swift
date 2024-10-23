//
//  HTUserDefaults.swift
//  LeiaRTCDemo
//
//  Created by caozheng on 2022/11/25.
//

import Foundation

class HTUserDefaults {
    
    private static let userDefaults = UserDefaults.standard
        
    static func setValue<T: Codable>(_ value: T?, for key: String) {
        guard let aValue = value else {
            userDefaults.set(nil, forKey: key)
            return
        }
        do {
            //编码成data进行存储
            //在ipadmini，iOS12.5.6上，String, Int等基础类型会报"Top-level Int encoded as number JSON fragment."错误。在iPhone11，iOS16.2上不会报错
            let data = try JSONEncoder().encode(aValue)
            userDefaults.set(data, forKey: key)
        } catch {
            debugPrint("trying set as raw when: \(error)")
            userDefaults.set(aValue, forKey: key)
        }
    }
    
    // 这个方法太没有业务性了，选择不暴露。必须要通过设置某种类型的nil来置空
    private
    static func setNil(for key: String) {
        userDefaults.set(nil, forKey: key)
    }
    
    static func getValue<T: Codable>(_ type: T.Type, for key: String) -> T? {
        guard let any = userDefaults.object(forKey: key) else {
            debugPrint("object is nil for key: \(key)")
            return nil
        }
        
        if let data = any as? Data {
            do {
                let obj = try JSONDecoder().decode(type, from: data)
                return obj
            } catch {
                debugPrint(error)
            }
        } else if let t = any as? T {
            return t
        }
        
        return nil
    }
}
