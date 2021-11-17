import Core
import CocoaLumberjackSwift
import CoreFoundation
import ThreadTech
import Proto

class InterviewTech: NSObject {
    
    public override init() {
        super.init()
        CanaryManager.shared.baseURL = "http://47.96.176.109"
        CanaryManager.shared.appSecret = "82e439d7968b7c366e24a41d7f53f47d"
        CanaryManager.shared.deviceId = "B65A818A-F4B4-4DC3-AE5A-3C7BA871BD8F"
        DDLog.add(DDTTYLogger.sharedInstance!)
        DDLog.add(CanaryTTYLogger())
        CanaryManager.shared.startLogger(domain: nil) {
            return [:]
        }
        NotificationCenter.default.addObserver(self, selector: #selector(run), name: .init(rawValue: DeviceRegistertedNotificationKey), object: nil)
    }
    
    @objc func run() {
        ThreadTech.runBatch()
        NotificationCenter.default.removeObserver(self, name: .init(rawValue: DeviceRegistertedNotificationKey), object: nil)
    }
    
    func waitForExit() {
        DDLogInfo("Hello,World!")
        CFRunLoopRun()
    }
}

@objc class CanaryTTYLogger: DDAbstractLogger {
    public override func log(message logMessage: DDLogMessage) {
        CanaryManager.shared.storeLogMessage(dict: logMessage.dictionaryWithValues(forKeys: CanaryManager.StoreLogKeys), timestamp: logMessage.timestamp.timeIntervalSince1970)
    }
}
