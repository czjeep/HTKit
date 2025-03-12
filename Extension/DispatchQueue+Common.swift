//
//  DispatchQueue+Common.swift
//  WuKongKit
//
//  Created by weitu on 2025/3/12.
//

import Foundation

extension DispatchQueue {
    
    static func executeOnMain(_ handler: @escaping WKVoidClosure) {
        if Thread.isMainThread {
            handler()
        } else {
            DispatchQueue.main.async(execute: {
                handler()
            })
        }
    }
}
