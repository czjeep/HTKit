//
//  Date+HTKit.swift
//  WuKongKit
//
//  Created by weitu on 2025/9/25.
//

import Foundation

extension Date {
    
    ///毫秒时间戳
    func timestampInMilliseconds() -> Int {
        return Int(timeIntervalSince1970*1000)
    }
    
    ///秒时间戳
    func timestampInSeconds() -> Int {
        return Int(timeIntervalSince1970)
    }
}
