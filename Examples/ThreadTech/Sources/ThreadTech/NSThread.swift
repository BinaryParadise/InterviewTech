//
//  File.swift
//  
//
//  Created by Rake Yang on 2021/11/23.
//

import Foundation
import CocoaLumberjackSwift

/// 模拟售票功能
class NSThreadTech {
    var tickets: Int = 20
    var terminated: Bool = false
    let lock = NSLock()
    func exec() {
        if #available(macOS 10.12, *) {
            // 创建线程
            let thread = Thread {
                self.sale(window: "窗口1", d: true)
            }
            
            // 启动线程
            thread.start()
            
            Thread {
                self.sale(window: "窗口2")
            }.start()
        } else {
            let thread = Thread(target: self, selector: #selector(onThread), object: nil)
            thread.start()
        }
    }
    
    func sale(window: String, d: Bool = false) {
        while !terminated {
            lock.lock()
            if self.tickets > 0 {
                self.tickets -= 1
                if d {
                    DDLogDebug("【\(window)】售票 1 张，剩余\(self.tickets)")
                } else {
                    DDLogWarn("【\(window)】售票 1 张，剩余\(self.tickets)")
                }
                lock.unlock()
                if self.tickets == 0 {
                    DDLogInfo("票已售光，停止销售")
                    self.terminated = true
                } else {
                    Thread.sleep(forTimeInterval: Double.random(in: 0.1...0.5))
                }
            }
        }
    }
    
    @objc func onThread() {
        delay(3, label: "任务1")
    }
}

func synchronized<T>(_ lock: AnyObject, _ closure: () throws -> T) rethrows -> T {
    objc_sync_enter(lock)
    defer { objc_sync_exit(lock) }
    return try closure()
}
