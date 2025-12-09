//
//  HiLeiaLogApi.swift
//  HiLeiaLog
//
//  Created by caozheng on 2022/4/6.
//

import Foundation
import CocoaLumberjack

public class HiLeiaLogApi: NSObject {
    
    let impl: LumberjackLog
    let moduleName: String
    
    /// 创建实例。日志文件中保存error, warning, info等级的日志
    /// - Parameters:
    ///   - directory: nil是Documents文件夹
    ///   - moduleName: 会当作日志文件名的前缀；会当作控制台日志的前缀；
    ///   - consolLoggerEnable: 是否要在控制台打印日志。如果设置为yes会打印所有等级的日志
    @objc public init(_ directory: String?,
                      _ moduleName: String,
                      _ consolLoggerEnable: Bool) {
        var aDirectory: String! = directory
        if aDirectory == nil {
            aDirectory = Self.document
        }
        
        if !FileManager.default.fileExists(atPath: aDirectory) {
            let url = URL(fileURLWithPath: aDirectory, isDirectory: true)
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                debugPrint(error)
            }
        }
            
        impl = LumberjackLog(aDirectory, filePrefix: moduleName)
        if consolLoggerEnable {
            impl.addConsolLogger()
        }
        self.moduleName = moduleName
        super.init()
    }
    
    ///Verbose：开发调试过程中一些详细信息，不应该编译进产品中，只在开发阶段使用。
    public func v(tag: String? = nil,
                  _ message: Any...,
                  file: StaticString = #fileID,
                  line: UInt = #line,
                  function: StaticString = #function) {
        let tag = tag ?? moduleName
        impl.log(message: message,
                 tag: tag,
                 file: file,
                 line: line,
                 function: function,
                 flag: .verbose)
    }
    
    ///Debug：用于调试的信息，编译进产品，但可以在运行时关闭。
    public func d(tag: String? = nil,
                  _ message: Any...,
                  file: StaticString = #fileID,
                  line: UInt = #line,
                  function: StaticString = #function) {
        let tag = tag ?? moduleName
        impl.log(message: message,
                 tag: tag,
                 file: file,
                 line: line,
                 function: function,
                 flag: .debug)
    }
    
    ///Info：例如一些运行时的状态信息，这些状态信息在出现问题的时候能提供帮助。
    public func i(tag: String? = nil,
                  _ message: Any...,
                  file: StaticString = #fileID,
                  line: UInt = #line,
                  function: StaticString = #function) {
        let tag = tag ?? moduleName
        impl.log(message: message,
                 tag: tag,
                 file: file,
                 line: line,
                 function: function,
                 flag: .info)
    }
    
    ///Warn：警告系统出现了异常，即将出现错误。
    public func w(tag: String? = nil,
                  _ message: Any...,
                  file: StaticString = #fileID,
                  line: UInt = #line,
                  function: StaticString = #function) {
        let tag = tag ?? moduleName
        impl.log(message: message,
                 tag: tag,
                 file: file,
                 line: line,
                 function: function,
                 flag: .warning)
    }
    
    ///Error：系统已经出现了错误。
    public func e(tag: String? = nil,
                  _ message: Any...,
                  file: StaticString = #fileID,
                  line: UInt = #line,
                  function: StaticString = #function) {
        let tag = tag ?? moduleName
        impl.log(message: message,
                 tag: tag,
                 file: file,
                 line: line,
                 function: function,
                 flag: .error)
    }
    
    /// 抓取崩溃信息
    @objc public static func catchException(block: ((String) -> Void)?) {
        UncaughtException.install(with: block)
        SignalException.install(with: block)
    }
}

/// 日志等级
@objc enum LogLevel: Int {
    case Verbose
    case Debug
    case Info
    case Warn
    case Error
}

extension HiLeiaLogApi {
    
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



