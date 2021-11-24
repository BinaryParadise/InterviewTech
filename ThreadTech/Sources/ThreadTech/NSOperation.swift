//
//  NSOperation.swift
//  
//
//  Created by Rake Yang on 2021/11/23.
//

import Foundation
import CocoaLumberjackSwift

class NSOperationTech {
    func exec() {
        let op = BlockOperation {
            delay(3, label: "胜利")
        }
        
        let wash = BlockOperation {
            delay(2, label: "游戏")
        }
        
        let cut = BlockOperation {
            delay(5, label: "匹配")
        }
        
        let stir = BlockOperation {
            delay(3, label: "对局")
        }
        
        
        op.addDependency(stir)
        stir.addDependency(cut)
        cut.addDependency(wash)

#if false
        
        stir.start()
        wash.start()
        cut.start()
        op.start()

#else

        let oq = OperationQueue.main
        oq.maxConcurrentOperationCount = 2
        oq.addOperation(op)
        oq.addOperation(stir)
        oq.addOperation(cut)
        oq.addOperation(wash)

#endif
    }
}
