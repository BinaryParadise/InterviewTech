//
//  KVOViewController.swift
//  InterviewUI
//
//  Created by rakeyang on 2022/3/12.
//

import UIKit
import SnapKit
import CocoaLumberjack

class KVOViewController: UIViewController {

    var computer: Computer = Computer()
    var yuner = Yunyun()
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let changeBtn = UIButton(type: .custom)
        changeBtn.backgroundColor = UIColor.orange
        changeBtn.setTitle("Random", for: .normal)
        view.addSubview(changeBtn)
        changeBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        changeBtn.addTarget(self, action: #selector(textChanged(_:)), for: .touchUpInside)
        
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(changeBtn.snp.bottom).offset(20)
        }
        
        computer.addObserver(self, forKeyPath: "label", options: [.new, .old], context: nil)
        yuner.addObserver(self, forKeyPath: "level", options: [.new, .old], context: nil)
    }
    
    @IBAction func textChanged(_ sender: Any) {
        computer.label = "\(Int64.random(in: 10000...100000))"
        computer.setValue("\(Int64.random(in: 10000...100000))", forKey: "label")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "label", change != nil  {
            DDLogDebug("label: change from [\(change![NSKeyValueChangeKey.oldKey]!)] to [\(change![NSKeyValueChangeKey.newKey]!)]")
            label.setValue(change![NSKeyValueChangeKey.newKey], forKey: "text")
        }
    }
    
    deinit {
        computer.removeObserver(self, forKeyPath: "label")
        if #available(iOS 9, *) {
            yuner.removeObserver(self, forKeyPath: "level")
        }
    }

}
