//
//  AppDelegate.swift
//  InterviewUI
//
//  Created by Rake Yang on 2021/11/29.
//

import UIKit
import InterviewBase
#if CANARY_ENABLE
import Canary

class CanaryTTYLogger: DDAbstractLogger {
    static let shared = CanaryTTYLogger()
    private override init() {}
    public override func log(message logMessage: DDLogMessage) {
        CanaryManager.shared.storeLogMessage(dict: logMessage.dictionaryWithValues(forKeys: CanaryManager.StoreLogKeys), timestamp: logMessage.timestamp.timeIntervalSince1970)
    }
}

#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        #if CANARY_ENABLE
        // 金丝雀配置
        CanaryManager.shared.baseURL = "http://47.96.176.109"
        CanaryManager.shared.appSecret = "82e439d7968b7c366e24a41d7f53f47d"
        CanaryManager.shared.deviceId = "B65A818A-F4B4-4DC3-AE5A-3C7BA871BD8F"
        CanaryManager.shared.startLogger(domain: nil) {
            return [:]
        }
        
        DDLog.add(CanaryTTYLogger.shared)
        #endif
        
        LoggingConfiguration.configure()

        return true
    }

}
