//
//  FileManager+HTKit.swift
//  WuKongKit
//
//  Created by weitu on 2024/10/30.
//

import Foundation

extension FileManager {
    
    @objc public static let caches: String? = {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        return path.first
    }()
    
    @objc public static let document: String? = {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return path.first
    }()
    
    @objc public static let library: String? = {
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
        return path.first
    }()
}
