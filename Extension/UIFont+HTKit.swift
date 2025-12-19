//
//  UIFont+HTKit.swift
//  HiLeia.PS
//
//  Created by caozheng on 2022/10/17.
//

import UIKit

extension UIFont {
    
    /// 粗体 weight-700。没有这种字体
    static private func pingFangBold(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Bold", size: size)!
    }
    
    /// 中粗体 weight-600
    static func pingFangSemibold(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Semibold", size: size)!
    }
    
    /// 中黑体 weight-500
    static func pingFangMedium(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Medium", size: size)!
    }
    
    /// 常规体 weight-400
    static func pingFangRegular(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Regular", size: size)!
    }
    
    /// 细体 weight-300
    static func pingFangLight(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Light", size: size)!
    }
    
    /// 纤细体 weight-200
    static func pingFangThin(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Thin", size: size)!
    }
    
    /// 极细体 weight-100
    static func pingFangUltralight(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Ultralight", size: size)!
    }
}

extension UIFont {
    
    static func DINAlternateBold(_ size: CGFloat) -> UIFont {
        UIFont(name: "DINAlternate-Bold", size: size)!
    }
}
