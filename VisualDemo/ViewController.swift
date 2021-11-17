//
//  ViewController.swift
//  VisualDemo
//
//  Created by Rake Yang on 2021/11/16.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let queue = DispatchQueue(label: "串行")
        print("\(Thread.current.desc) s")
        queue.async {
            print("\(Thread.current.desc) 1")
        }
        queue.async {
            print("\(Thread.current.desc) 2")
        }
        queue.async {
            print("\(Thread.current.desc) 3")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? SecondViewController
        if let type = QueueType(rawValue: Int(segue.identifier!)!) {
            switch type {
            case .current:
                break
            case .serial:
                vc?.taskQueue = DispatchQueue(label: "task")
            case .concurrent:
                vc?.taskQueue = DispatchQueue(label: "task", attributes: .concurrent)
            case .global:
                vc?.taskQueue = DispatchQueue.global()
            case .main:
                vc?.taskQueue = DispatchQueue.main
            }
        }
    }
}

