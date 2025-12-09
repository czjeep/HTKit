//
//  HTWildWeakSet.swift
//  WuKongKit
//
//  Created by weitu on 2024/11/12.
//

import Foundation

class HTWildWeakSet: NSObject {
    
    private class Wrapper: NSObject {
        weak var value: NSObjectProtocol?
    }
    
    private var arr = [Wrapper]()
    
    /// 多次添加同一个对象，只保留第一个
    func append(_ obj: NSObjectProtocol) {
        cleanNilObserver()
        
        // 已存在则不处理
        guard arr.firstIndex(where: { $0.value === obj }) == nil else {
            return
        }
        
        let wrapper = Wrapper()
        wrapper.value = obj
        arr.append(wrapper)
    }
    
    /// 移除一个对象
    func remove(_ obj: NSObjectProtocol) {
        cleanNilObserver()
        
        // 不存在则不处理
        guard let index = arr.firstIndex(where: { $0.value === obj }) else {
            return
        }
        
        arr.remove(at: index)
    }
    
    private func cleanNilObserver() {
        let needRemove = arr.filter({ $0.value == nil })
        for item in needRemove {
            arr.removeAll(where: { $0 === item })
        }
    }
    
    func values<T>(_ type: T.Type) -> [T] {
        cleanNilObserver()
        
        let temp = arr.compactMap({ $0.value as? T })
        return temp
    }
}
