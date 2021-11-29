//
//  ThreadPing.swift
//  InterviewUI
//
//  Created by Rake Yang on 2021/11/29.
//

import Foundation
import UIKit

class ThreadPing: Thread {
    
    /// 监控间隔
    private var threshold: TimeInterval = 0.1
    
    /// 信号量控制
    private var sema = DispatchSemaphore(value: 0)
    
    /// 检测到卡顿的回调
    var didReceived: ((_ info: [String : Any]) -> Void)?
    
    /// App是否激活状态
    var appInActive: Bool = false
    
    /// 堆栈信息
    private var anrInfo: String = ""
    
    /// 检测开始时间
    private var startTime: TimeInterval = 0
    
    /// 是否等待主线程中响应
    private var wating: Bool = false
    
    init(threshold: TimeInterval = 0.1, receive: @escaping ([String : Any]) -> Void) {
        super.init()
        self.threshold = threshold
        self.didReceived = receive
        // App退到后台暂停检测
        NotificationCenter.default.addObserver(self, selector: #selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    override func main() {
        //检测到卡顿时触发回调
        let verifyReport: () -> Void = { [weak self] in
            guard let self = self else { return }
            if self.anrInfo.count > 0 {
                let duration = Date().timeIntervalSince1970 - self.startTime
                self.didReceived?([
                    "title": Date().timeIntervalSince1970,
                    "duration": duration,//单位ms
                    "content": self.anrInfo
                    ])
                self.anrInfo = ""
            }
        }
                    
        repeat {
            if (self.appInActive) {
                self.wating = true
                self.anrInfo = "";
                self.startTime = Date().timeIntervalSince1970;
                DispatchQueue.main.async { [weak self] in
                    //解除等待
                    self?.wating = false
                    self?.sema.signal()
                }
                Thread.sleep(forTimeInterval: threshold)
                if self.didReceived != nil {
                    //当前主线程堆栈信息
                    self.anrInfo = BSBacktraceLogger.bs_backtraceOfMainThread()
                }

                if sema.wait(timeout: .now() + 2) == .timedOut {
                    // 主线程超过两秒不响应即视为卡顿
                    verifyReport();
                } else {
                    print("未检测到卡顿")
                }
            } else {
                Thread.sleep(forTimeInterval: threshold)
            }
        } while !isCancelled

    }
    
    @objc func becomeActive() {
        appInActive = true
    }
    
    @objc func enterBackground() {
        appInActive = false
    }
}
