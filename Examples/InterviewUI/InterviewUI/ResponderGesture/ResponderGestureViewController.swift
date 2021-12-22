//
//  ResponderGestureViewController.swift
//  InterviewUI
//
//  Created by Rake Yang on 2021/12/20.
//

import Foundation
import UIKit

class Computer {
    func powerOn() {
        print("启动电源")
    }
}

class ResponderGestureViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let t = Computer.powerOn
        let x = t(Computer())
    }
    
    @IBAction func onClick(_ sender: Any) {
        print("\(sender)")
    }
}
