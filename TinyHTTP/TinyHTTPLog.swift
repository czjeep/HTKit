//
//  TinyHTTPLog.swift
//  HiARSpace
//
//  Created by caozheng on 2022/12/13.
//

import Foundation

// 预留的日志
class TinyHTTPLog {
    
    // 需要用户实现这个handler
    static var handler: ((_ message: Any,
                          _ file: StaticString,
                          _ line: UInt,
                          _ function: StaticString) -> Void)?
    
    static func i(_ message: Any,
                  file: StaticString = #fileID,
                  line: UInt = #line,
                  function: StaticString = #function) {
        handler?(message, file, line, function)
    }
    
    // 有些日志操作可能比较耗时。用户如果没有具体实现日志，则这部分日志将不会运行。
    static func condition(_ closure: () -> Void) {
        if handler != nil {
            closure()
        }
    }
}
