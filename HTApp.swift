//
//  HTApp.swift
//  HiMeta
//
//  Created by lft on 2023/4/19.
//

import Foundation

public enum HTApp {
    
    /// 是否是安装app后第一次打开。
    private(set) static var isInstallFirstOpen: Bool!
    /// 是否是当前版本第一次打开。
    private(set) static var isCurrentVersionFirstOpen: Bool!
    
    /// 需要在didFinishLaunching后调用仅一次
    static func setupOpen() {
        let defaults = UserDefaults.standard
        let HTAppHasBeenOpend = "HTAppHasBeenOpend"
        
        let installKey = HTAppHasBeenOpend + "Install"
        if defaults.bool(forKey: installKey) {
            isInstallFirstOpen = false
        } else {
            isInstallFirstOpen = true
            defaults.set(true, forKey: installKey)
        }
        
        let versionKey = HTAppHasBeenOpend + version
        if defaults.bool(forKey: versionKey) {
            isCurrentVersionFirstOpen = false
        } else {
            isCurrentVersionFirstOpen = true
            defaults.set(true, forKey: versionKey)
        }
    }
    
    /// Check if the app has been installed from TestFlight.
    ///
    /// - Returns: Returns `true` if the app has been installed via TestFlight, otherwise `false`.
    public static func isFromTestFlight() -> Bool {
        guard let appStoreReceiptURL = Bundle.main.appStoreReceiptURL else {
            return false
        }
        
        return appStoreReceiptURL.lastPathComponent == "sandboxReceipt"
    }
}


// MARK: - HTApp extension

/// Extends BFApp with project infos.
public extension HTApp {
    // MARK: - Variables
    
    /// Return the App name.
    /// 如果用户没设置DisplayName的话，这个值为空。这时app的名字会使用bundleName。
    static var name: String = {
        HTApp.stringFromInfoDictionary(forKey: "CFBundleDisplayName")
    }()
    
    static var bundleName: String = {
        HTApp.stringFromInfoDictionary(forKey: "CFBundleName")
    }()
    
    /// Returns the App version.
    static var version: String = {
        HTApp.stringFromInfoDictionary(forKey: "CFBundleShortVersionString")
    }()
    
    /// Returns the App build.
    static var build: String = {
        HTApp.stringFromInfoDictionary(forKey: "CFBundleVersion")
    }()
    
    /// Returns the App executable.
    static var executable: String = {
        HTApp.stringFromInfoDictionary(forKey: "CFBundleExecutable")
    }()
    
    /// Returns the App bundle.
    static var bundle: String = {
        HTApp.stringFromInfoDictionary(forKey: "CFBundleIdentifier")
    }()
    
    // MARK: - Functions
    
    /// Returns a String from the Info dictionary of the App.
    ///
    /// - Parameter key: Key to search.
    /// - Returns: Returns a String from the Info dictionary of the App.
    private static func stringFromInfoDictionary(forKey key: String) -> String {
        guard let infoDictionary = Bundle.main.infoDictionary, let value = infoDictionary[key] as? String else {
            return ""
        }
        
        return value
    }
}
