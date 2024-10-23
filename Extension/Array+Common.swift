//
//  Array+Common.swift
//  HiLeia6
//
//  Created by caozheng on 2021/10/20.
//

import Foundation

extension Array {

    func safeElement(_ index: Int) -> Element? {
        if index < count {
            return self[index]
        }
        return nil
    }
    
    @discardableResult
    @inlinable public mutating func safeRemoveFirst() -> Element? {
        if count > 0 {
            return removeFirst()
        }
        return nil
    }
    
    @discardableResult
    @inlinable public mutating func safeRemoveLast() -> Element? {
        if count > 0 {
            return removeLast()
        }
        return nil
    }
}
