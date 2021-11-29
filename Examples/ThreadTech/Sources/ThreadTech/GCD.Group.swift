//
//  File.swift
//  
//
//  Created by Rake Yang on 2021/11/23.
//

import Foundation
import CocoaLumberjackSwift

extension GCD {
    struct GroupTech {
        static func exec() {
            manual()
            automatic()
        }
        
        static func manual() {
            let group = DispatchGroup()
            
            group.enter()
            DispatchQueue.global().async {
                delay(5, label: "任务1")
                group.leave()
            }
            
            group.enter()
            DispatchQueue.global().async {
                delay(2, label: "任务2")
                group.leave()
            }
                                    
            switch group.wait(timeout: .now() + 0.5) {
            case .success:
                DDLogVerbose("未超时")
            case .timedOut:
                DDLogVerbose("已超时")
            }
            
            group.notify(queue: .main) {
                DDLogWarn("手动管理: 全部完成")
            }
        }
        
        static func automatic() {
            let group = DispatchGroup()
            
            DispatchQueue.global().async(group: group) {
                delay(5, label: "任务1")
            }
            
            DispatchQueue.global().async(group: group) {
                delay(2, label: "任务2")
            }
            
            group.notify(queue: .main) {
                DDLogWarn("自动管理: 全部完成")
            }
        }
    }
}
