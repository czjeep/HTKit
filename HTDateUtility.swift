//
//  HTDateUtility.swift
//  WuKongKit
//
//  Created by weitu on 2025/2/13.
//

import UIKit

/// 时间矫正工具类
class HTDateUtility: NSObject {
    
    ///差值。秒：正确时间戳-系统时间戳
    static private var diffValue: Double = 0
    
    /// 矫正差值：正确时间戳毫秒
    static func correctWithMilliseconds(_ timestamp: Double) {
        correctWithSeconds(timestamp/1000)
    }
    
    /// 矫正差值：正确时间戳秒
    static func correctWithSeconds(_ timestamp: Double) {
        if #available(iOS 15, *) {
            diffValue = timestamp-Date.now.timeIntervalSince1970
        } else {
            diffValue = timestamp-Date().timeIntervalSince1970
        }
    }
    
    /// 当前时间（矫正后）
    static var now: Date {
        return Date(timeIntervalSinceNow: diffValue)
    }
    
    /// 当前时间（系统的）
    static var system_now: Date {
        if #available(iOS 15, *) {
            return Date.now
        } else {
            return Date()
        }
    }
}
