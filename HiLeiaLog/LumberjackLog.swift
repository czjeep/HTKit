//
//  LumberjackLog.swift
//  HiLeiaLog
//
//  Created by caozheng on 2022/4/6.
//

import Foundation
import CocoaLumberjack

class LumberjackLog: NSObject {

    private var ddLog = DDLog()
    
    init(_ directory: String?, filePrefix: String) {
        super.init()
        
        addFileLogger(directory, filePrefix: filePrefix)
    }
    
    func addConsolLogger() {
        if #available(iOS 10.0, *) {
            let consolLogger = DDOSLogger(subsystem: nil, category: nil)
            consolLogger.logFormatter = LumberjackConsolLogFormatter()
            ddLog.add(consolLogger, with: .all)  //控制台输出所有等级的日志
        } else {
            
        }
    }
    
    private func addFileLogger(_ directory: String?, filePrefix: String) {
        let manager = LumberjackLogFileManager(logsDirectory: directory)
        manager.filePrefix = filePrefix
        
        let fileLogger = DDFileLogger(logFileManager: manager)
        fileLogger.logFormatter = LumberjackFileLogFormatter()
        ddLog.add(fileLogger, with: .info)  //文件中保存error, warning, info等级的日志
    }
    
    func log(message: Any...,
             tag: String,
             file: StaticString,
             line: UInt,
             function: StaticString,
             flag: DDLogFlag) {
        _DDLogMessage("\(message)",
                      level: .all,
                      flag: flag,
                      context: 0,
                      file: file,
                      function: function,
                      line: line,
                      tag: tag,
                      asynchronous: false,
                      ddlog: ddLog)
    }
}

fileprivate
extension DDLogFlag {
    
    var flagName: String {
        switch self {
        case .error:
            return "error"
        case .debug:
            return "debug"
        case .info:
            return "info"
        case .verbose:
            return "verbose"
        case .warning:
            return "warning"
        default:
            return "NA"
        }
    }
}

fileprivate let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.formatterBehavior = .behavior10_4
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
    dateFormatter.calendar = .init(identifier: .gregorian)
    return dateFormatter;
}()

fileprivate let StringExpectCount = 18

fileprivate
extension String {
    
    /// 去掉前后增加的字符串。因为不确定会增加上什么样的字符串，弃用这个方法。
    /// 有时候会默认的会加上[""]，eg: ["============== application Launching =========="]
    /// 有时候只会加上[]，eg：[true]
    @available(*, deprecated, message: "去掉前后增加的字符串。因为不确定会增加上什么样的字符串，弃用这个方法。")
    func perf() -> String {
        if count >= 4 {
            var n = count - 2
            var str = self.prefix(n)
            n -= 2
            str = str.suffix(n)

            return String(str)
        }
        return self
    }
    
    /// 从前面开始，截取一定长度的字符串，长度不够则以空格补足
    /// - Returns: 返回截取出来的或者补足后的字符串
    func prefixString() -> String {
        let strCount = count
        if strCount < StringExpectCount {
            let need = StringExpectCount - strCount
            let sub = String(repeating: " ", count: need)
            return self + sub
        } else {
            return String(prefix(StringExpectCount))
        }
    }
}

class LumberjackConsolLogFormatter: NSObject, DDLogFormatter {
    
    func format(message logMessage: DDLogMessage) -> String? {
        let file = logMessage.fileName.prefixString()
        let line = logMessage.line
        
        let flagStr = logMessage.flag.flagName
//        let tag = logMessage.representedObject ?? ""  //3.8.0
        let tag = logMessage.tag ?? ""  //3.6.1
        let msg = logMessage.message
        
        return "[\(tag) \(file) \(line)] [\(flagStr)] \(msg)"
    }
}

class LumberjackFileLogFormatter: NSObject, DDLogFormatter {
    
    func format(message logMessage: DDLogMessage) -> String? {
        let timeStr = dateFormatter.string(from: logMessage.timestamp)
         
        let thread = logMessage.threadID
        
        let file = logMessage.fileName.prefixString()
        let line = logMessage.line
        var funcName = logMessage.function ?? ""
        funcName = funcName.prefixString()
        
        let flagStr = logMessage.flag.flagName
//        let tag = logMessage.representedObject ?? ""
        let msg = logMessage.message
        
        return "[\(timeStr)[\(thread)]\(file):\(line):\(funcName)] [\(flagStr)]: \(msg)"
    }
}

class LumberjackLogFileManager: DDLogFileManagerDefault {
    
    var filePrefix: String!
    
    lazy var dateFormatter: DateFormatter = {
        let obj = DateFormatter()
        obj.dateFormat = "yyyy-MM-dd-hh--mm-ss"
        return obj
    }()
    
    override var newLogFileName: String {
        let timeStr = dateFormatter.string(from: Date())
        
        return filePrefix + " " + timeStr + ".log"
    }
    
    override func isLogFile(withName fileName: String) -> Bool {
        return false
    }
    
    override var logFileHeader: String? {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let machine = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        let model = machine
        let sys = UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        let appBundleId = Bundle.main.bundleIdentifier ?? ""
        let appVersion = getBundleVersion(with: Bundle.main) ?? "null"
        let selfVersion = getBundleVersion(with: Bundle(for: LumberjackLogFileManager.self)) ?? "null"
        
        let fileDate = Date()
        
        let header = """
        Hardware Model: \(model)
        OS Version:     \(sys)
        App Identifier: \(appBundleId)
        App Version:    \(appVersion)
        Self Version:    \(selfVersion)
        File Date:      \(fileDate)
        
        
        """
        return header
    }
    
    func getBundleVersion(with bundle: Bundle) -> String? {
        guard let infoDic = bundle.infoDictionary,
              let version = infoDic["CFBundleShortVersionString"] as? String
        else {
            return nil
        }
        
        let result: String
        if let build = infoDic["CFBundleVersion"] as? String {
            result = [version, build].joined(separator: "-")
        } else {
            result = version
        }
        
        return result
    }
}
