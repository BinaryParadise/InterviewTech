//
//  ThreadTech.swift
//  
//
//  Created by Rake Yang on 2021/11/16.
//

import Foundation
import CocoaLumberjackSwift

public class ThreadTech {
    static let allTypes: [QueueType] = [.serial, .concurrent, .global, .main]
    @available(macOS 10.15, *)
    public class func runBatch() {
        let taskQueue = QueueType.serial.queue(label: "task")
        let targetType: QueueType = .serial
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            DDLogWarn("==========================================================================================")
            run(task: taskQueue, type: targetType)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            DDLogWarn("==========================================================================================")
            run(task: taskQueue, type: targetType, async: false)
        }
    }
    
    public class func run(task queue: DispatchQueue, type: QueueType, async: Bool = true) {
        //执行任务的队列
        var targetQueue: DispatchQueue
        switch type {
        case .serial:
            targetQueue = DispatchQueue(label: "target")
        case .concurrent:
            targetQueue = DispatchQueue(label: "target", attributes: .concurrent)
        case .global:
            targetQueue = DispatchQueue.global()
        case .main:
            targetQueue = DispatchQueue.main
        }
        
        targetQueue.async {
            DDLogError("\(Thread.current.desc) \(queue) => \(targetQueue) async=\(async)")
        }
        
        targetQueue.async {
            GCD.QueueTech.exec(queue: queue, async: async)
        }
    }
}
