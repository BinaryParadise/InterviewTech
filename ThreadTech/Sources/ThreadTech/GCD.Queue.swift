//
//  File.swift
//  
//
//  Created by Rake Yang on 2021/11/16.
//

import Foundation
import CocoaLumberjackSwift

public enum QueueType: Int, CustomStringConvertible {
    case serial     = 1
    case concurrent = 2
    case global     = 3
    case main       = 4
    
    public func queue(label: String) -> DispatchQueue {
        switch self {
        case .serial:
            return DispatchQueue(label: label)
        case .concurrent:
            return DispatchQueue(label: label, attributes: .concurrent)
        case .global:
            return .global()
        case .main:
            return .main
        }
    }
    
    public var description: String {
        switch self {
        case .serial:
            return "串行队列"
        case .concurrent:
            return "并行队列"
        case .global:
            return "全局队列"
        case .main:
            return "主队列"
        }
    }
}

enum GCD {
}

extension GCD {
    class QueueTech {
        
        class func exec(queue: DispatchQueue, async: Bool = true) {
            if async {
                queue.async {
                    delay(3, label: "任务 1")
                }
                
                queue.async {
                    delay(5, label: "任务 2")
                }
                
                queue.async {
                    delay(2, label: "任务 3")
                }
            } else {
                if Thread.current.isMainThread && queue is dispatch_queue_main_t {
                    DDLogError("DeadLock")
                    return
                }
                queue.sync {
                    delay(3, label: "任务 1")
                }
                
                queue.sync {
                    delay(5, label: "任务 2")
                }
                
                queue.sync {
                    delay(2, label: "任务 3")
                }
            }
        }
    }
}

func delay(_ interval: TimeInterval, label: String) {
    var counter: Int = Int(interval * 50000000)
    let time = Date()
    DDLogInfo("\(Thread.current.desc) \(label) 启动")
    repeat {
        counter -= 1
    } while counter > 0
    DDLogDebug("\(Thread.current.desc) \(label) 完成耗时: \(((Date().timeIntervalSince1970 - time.timeIntervalSince1970) * 1000).rounded())ms")
}

extension Thread {
    var number: Int {
        let re = try! NSRegularExpression(pattern: "number = (\\d+)", options: [.caseInsensitive])
        if let match = re.matches(in: description, options: [], range: .init(location: 0, length: description.count)).first {
            return Int((description as NSString).substring(with: match.range(at: 1))) ?? 1
        }
        return 1
    }
    var desc: String {
        let n = isMainThread ? "main" : (name == "" ? "null" : name)
        return "\(n ?? "null")=\(number)"
    }
}
