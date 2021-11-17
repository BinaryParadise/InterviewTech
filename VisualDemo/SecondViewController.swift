//
//  SecondViewController.swift
//  VisualDemo
//
//  Created by Rake Yang on 2021/11/16.
//

import Foundation
import UIKit

class SecondViewController: UITableViewController {
    var taskQueue: DispatchQueue?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? ResultViewController
        vc?.taskQueue = taskQueue
        vc?.type2 = QueueType(rawValue: Int(segue.identifier!)!)!
    }
}
