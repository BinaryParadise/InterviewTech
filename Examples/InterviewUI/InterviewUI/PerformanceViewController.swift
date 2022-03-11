//
//  PerformanceViewController.swift
//  InterviewUI
//
//  Created by Rake Yang on 2021/11/29.
//

import UIKit
import CocoaLumberjack

/// 卡顿检测
class PerformanceViewController: UIViewController {

    var ping: ThreadPing?
    
    @IBOutlet weak var timeLabel: UILabel!
    let fmt = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
        let timer = Timer.scheduledTimer(timeInterval: 0.09, target: self, selector: #selector(onTimer(_:)), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        
        ping = ThreadPing(threshold: 0.5, receive: { dict in
            DDLogWarn("\(String(describing: dict["content"]!))")
        })
        ping?.start()
    }
    
    @IBAction func onTimer(_ sender: Any) {
        DispatchQueue.main.async {
            self.timeLabel.text = "\(self.fmt.string(from: Date()))"
        }
    }

    @IBAction func onButton(_ sender: Any) {
        DDLogInfo("Sleep 3.5s")
        Thread.sleep(forTimeInterval: 3.5)
    }
    
}
