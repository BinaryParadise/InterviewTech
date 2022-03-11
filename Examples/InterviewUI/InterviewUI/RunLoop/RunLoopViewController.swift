//
//  RunLoopViewController.swift
//  InterviewUI
//
//  Created by rakeyang on 2022/3/11.
//

import UIKit
import CocoaLumberjack

class RunLoopViewController: UITableViewController {

    weak var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIScrollView滚动时会转到UITrackingRunLoopMode
        #if false
        
        //scheduled: 自动添加到当前RunLoop中
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimer(_:)), userInfo: self, repeats: true)
        
        //1、加入到CommonMode
        RunLoop.current.add(timer, forMode: .common)
        #else
        //2、在其它线程中处理
        DispatchQueue.global().async {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer(_:)), userInfo: self, repeats: true)
            RunLoop.current.run()
        }
        #endif
    }
    
    @IBAction func onTimer(_ sender: Any) {
        DDLogDebug("\(Date())")
    }
}
