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
        guard let delegate = sceneDelegate as? UIWindowSceneDelegate else {
            return nil
        }
        return delegate.window!
    }
}
