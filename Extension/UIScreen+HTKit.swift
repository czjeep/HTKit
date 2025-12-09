//
//  UIScreen+HTKit.swift
//  WuKongKit
//
//  Created by caozheng on 2024/10/15.
//

import UIKit

// MARK: - UIScreen extension

/// This extesion adds some useful functions to UIScreen.
public extension UIScreen {
    // MARK: - Variables
    
    /// Get the screen width.
    static var screenWidth: CGFloat {
        UIScreen.fixedScreenSize().width
    }
    
    /// Get the screen height.
    static var screenHeight: CGFloat {
        UIScreen.fixedScreenSize().height
    }
    
    /// Get the maximum screen length.
    static var maxScreenLength: CGFloat {
        max(screenWidth, screenHeight)
    }
    /// Get the minimum screen length.
    static var minScreenLength: CGFloat {
        min(screenWidth, screenHeight)
    }
    
    // MARK: - Functions
    
    /// Check if current device has a Retina display.
    ///
    /// - Returns: Returns true if it has a Retina display, otherwise false.
    static func isRetina() -> Bool {
        UIScreen.main.responds(to: #selector(UIScreen.displayLink(withTarget:selector:))) && UIScreen.main.scale == 2.0
    }
    
    /// Check if current device has a Retina HD display.
    ///
    /// - Returns: Returns true if it has a Retina HD display, otherwise false.
    static func isRetinaHD() -> Bool {
        UIScreen.main.responds(to: #selector(UIScreen.displayLink(withTarget:selector:))) && UIScreen.main.scale == 3.0
    }
    
    /// Returns fixed screen size, based on device orientation.
    ///
    /// - Returns: Returns a GCSize with the fixed screen size.
    static func fixedScreenSize() -> CGSize {
        UIScreen.main.bounds.size
    }
}
