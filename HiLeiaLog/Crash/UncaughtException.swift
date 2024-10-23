//
//  UncaughtException.swift
//  HiLeiaLogIOS
//
//  Created by caozheng on 2022/12/29.
//

import Foundation

class UncaughtException: NSObject, @unchecked Sendable {
    
    fileprivate static let shared = UncaughtException()
    
    static func install(with block: ((String) -> Void)?) {
        shared.block = block

        installUncaughtExceptionHandler()
    }
    
    private var block: ((String) -> Void)?
    
    fileprivate func saveCrash(_ exceptionInfo: String) {
        block?(exceptionInfo)
    }
    
}

fileprivate func handleUncaughtException(exception: NSException) {
    // 异常的堆栈信息
    let stackArray = exception.callStackSymbols.joined(separator: "\n")
    
    // 出现异常的原因
    let reason = exception.reason ?? "NA"
    
    // 异常名称
    let name = exception.name.rawValue
    
    let exceptionInfo = String(format: "UncaughtException\nException reason：%@\nException name：%@\nException stack：%@", reason, name, stackArray)
    
    UncaughtException.shared.saveCrash(exceptionInfo)
}

fileprivate func installUncaughtExceptionHandler() {
//    let preHander = NSGetUncaughtExceptionHandler()
    /// 会覆盖掉之前设置的回调
    NSSetUncaughtExceptionHandler(handleUncaughtException(exception:))
}
