//
//  Bundle+Common.swift
//  WuKongKit
//
//  Created by caozheng on 2024/10/15.
//

import Foundation

/// 仅用来寻找bundle
fileprivate
class Goat {
    
}

extension Bundle {
    
    static let current: Bundle = {
        return Bundle(for: Goat.self)
    }()
}
