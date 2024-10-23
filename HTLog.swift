//
//  HTLog.swift
//  ToolKit
//
//  Created by caozheng on 2023/4/7.
//

import Foundation

class HTLog: NSObject {
    
    private static var logImpl: HiLeiaLogApi?
    
    static func setup(_ directory: String?, _ moduleName: String, _ consolLoggerEnable: Bool) {
        logImpl = HiLeiaLogApi(directory, moduleName, consolLoggerEnable)
        HiLeiaLogApi.catchException { crash in
            e(crash)
        }
    }
    
    static func i(_ message: Any...,
                  file: StaticString = #fileID,
                  line: UInt = #line,
                  function: StaticString = #function) {
        logImpl?.i(message, file: file, line: line, function: function)
    }
    
    static func w(_ message: Any,
                  file: StaticString = #fileID,
                  line: UInt = #line,
                  function: StaticString = #function) {
        logImpl?.w(message, file: file, line: line, function: function)
    }
    
    static func e(_ message: Any,
                  file: StaticString = #fileID,
                  line: UInt = #line,
                  function: StaticString = #function) {
        logImpl?.e(message, file: file, line: line, function: function)
    }
    
    static func d(_ message: Any...,
                  file: StaticString = #fileID,
                  line: UInt = #line,
                  function: StaticString = #function) {
        logImpl?.d(message, file: file, line: line, function: function)
    }
}
