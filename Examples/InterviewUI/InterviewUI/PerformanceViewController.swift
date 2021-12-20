//
//  PerformanceViewController.swift
//  InterviewUI
//
//  Created by Rake Yang on 2021/11/29.
//

import UIKit

class PerformanceViewController: UIViewController {

    var ping: ThreadPing?
    
    @IBOutlet weak var timeLabel: UILabel!
    let fmt = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.09, repeats: true) { t in
            DispatchQueue.main.async {
                self.timeLabel.text = "\(self.fmt.string(from: Date()))"
            }
        }
        RunLoop.main.add(timer, forMode: .common)
        
        ping = ThreadPing(threshold: 1.0, receive: { dict in
            print("\(String(describing: dict["content"]!))")
        })
        ping?.start()
        print("\(#function)")
    }

    @IBAction func onButton(_ sender: Any) {
        Thread.sleep(forTimeInterval: 3.5)
    }
    
}
