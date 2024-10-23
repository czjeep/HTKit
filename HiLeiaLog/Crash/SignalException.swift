//
//  SignalException.swift
//  HiLeiaLogIOS
//
//  Created by caozheng on 2022/12/29.
//

import Foundation

class SignalException: NSObject {
    
    fileprivate static let shared = SignalException()
    
    static func install(with block: ((String) -> Void)?) {
        shared.block = block
        installSignalExceptionHandler()
    }
    
    private var block: ((String) -> Void)?
    
    fileprivate func saveCrash(_ exceptionInfo: String) {
        block?(exceptionInfo)
    }

}

fileprivate let beacon_errorSignals: [Int32] = [SIGABRT,
                                                SIGBUS,
                                                SIGFPE,
                                                SIGILL,
                                                SIGSEGV,
                                                SIGTRAP,
                                                SIGTERM,
                                                SIGKILL]

fileprivate func handleSignalException(sig: Int32) {
    var mstr = "SignalException\n"
    mstr += "Exception stack：\n"
    // 异常的堆栈信息
    mstr += Thread.callStackSymbols.joined(separator: "\n")
    
    SignalException.shared.saveCrash(mstr)
    
    signal(sig, SIG_DFL)
}

fileprivate func installSignalExceptionHandler() {
    for item in beacon_errorSignals {
        signal(item, handleSignalException(sig:))
    }
}
