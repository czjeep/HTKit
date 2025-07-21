//
//  UIApplication+Common.swift
//  WuKongKit
//
//  Created by caozheng on 2024/10/15.
//

import UIKit

extension UIApplication {
    
    var sceneDelegate: UISceneDelegate? {
        return connectedScenes.first?.delegate
    }
    
    var window: UIWindow? {
        if let obj = sceneDelegate as? UIWindowSceneDelegate {
            return obj.window!
        }
        if let obj = delegate {
            return obj.window!
        }
        return nil
    }
    
    /// 打开app的系统设置页
    @discardableResult
    func goSetting() -> Bool {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
            return true
        }
        return false
    }
}
