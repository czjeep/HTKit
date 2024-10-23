//
//  UIFont+Common.swift
//  HiLeia.PS
//
//  Created by caozheng on 2022/10/17.
//

import UIKit

extension UIFont {
    
    /// 中粗体
    static func pingFangSemibold(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Semibold", size: size)!
    }
    
    /// 中黑体
    static func pingFangMedium(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Medium", size: size)!
    }
    
    /// 常规体
    static func pingFangRegular(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Regular", size: size)!
    }
    
    /// 细体
    static func pingFangLight(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Light", size: size)!
    }
    
    /// 纤细体
    static func pingFangThin(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Thin", size: size)!
    }
    
    /// 极细体
    static func pingFangUltralight(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Ultralight", size: size)!
    }
}
