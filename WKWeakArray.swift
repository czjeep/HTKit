//
//  WKWeakArray.swift
//  WuKongKit
//
//  Created by weitu on 2025/3/11.
//

import Foundation

class WKWeakArray<Element: NSObject>: NSObject {
    
    private class Wrapper: NSObject {
        weak var value: Element?
    }
    
    private var arr = [Wrapper]()
    
    /// 多次添加同一个对象，只保留第一个
    func append(_ obj: Element) {
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
    func remove(_ obj: Element) {
        cleanNilObserver()
        
        // 不存在则不处理
        guard let index = arr.firstIndex(where: { $0.value === obj }) else {
            return
        }
        
        arr.remove(at: index)
    }
    
    func first(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        cleanNilObserver()
        
        let t = values()
        return try t.first(where: predicate)
    }
    
    private func cleanNilObserver() {
        let needRemove = arr.filter({ $0.value == nil })
        for item in needRemove {
            arr.removeAll(where: { $0 === item })
        }
    }
    
    func values() -> [Element] {
        cleanNilObserver()
        
        let temp = arr.compactMap({ $0.value })
        return temp
    }
}
