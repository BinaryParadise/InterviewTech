//
//  File.swift
//  
//
//  Created by Rake Yang on 2021/12/24.
//

import Foundation
import CocoaLumberjack

public class LoggingConfiguration {
    
    /// 日志系统配置
    public class func configure() {
        DDTTYLogger.sharedInstance?.logFormatter = LogFormat()
        DDLog.add(DDTTYLogger.sharedInstance!)
    }
    
    class LogFormat: NSObject, DDLogFormatter {
        func format(message logMessage: DDLogMessage) -> String? {
            let fmt = DateFormatter()
            fmt.dateFormat = "MM-dd HH:mm:ss.SSS"
            return "\(fmt.string(from: logMessage.timestamp)) \(logMessage.function ?? "")+\(logMessage.line) \(logMessage.message)"
        }
    }
}
