//
//  ResultViewController.swift
//  VisualDemo
//
//  Created by Rake Yang on 2021/11/16.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    var taskQueue: DispatchQueue?
    var type2: QueueType = .current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIAlertController(title: "选择执行方式", message: nil, preferredStyle: .actionSheet)
        vc.addAction(UIAlertAction(title: "async", style: .default, handler: { action in
            ThreadTech.run(task: self.taskQueue!, type: self.type2, async: true)
        }))
        vc.addAction(UIAlertAction(title: "sync", style: .default, handler: { action in
            ThreadTech.run(task: self.taskQueue!, type: self.type2, async: false)
        }))
        vc.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        navigationController?.present(vc, animated: true, completion: nil)
    }
}
