//
//  ThreadViewController.swift
//  InterviewUI
//
//  Created by rakeyang on 2022/3/11.
//

import UIKit
import CocoaLumberjack

class ThreadViewController: UITableViewController {
    
    let serialQ = DispatchQueue(label: "serial_cur")
    let concurrentQ = DispatchQueue(label: "concurrent_cur", attributes: .concurrent)
    let globalQ = DispatchQueue.global()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("\(RunLoop.current.currentMode)")
    }
    
    func taskIn(current: DispatchQueue, target: DispatchQueue, label: String = "", _ sync: Bool = false) {
        DDLogVerbose("==================================================")
        DDLogInfo("\(current)==\(target)")
        current.async {
            DDLogWarn("当前: \(Thread.current) -> sync: \(sync)")
            if sync {
                target.sync {
                    DDLogDebug("\(label): 1 -> \(Thread.current)")
                }
                
                target.sync {
                    Thread.sleep(forTimeInterval: 1)
                    DDLogDebug("\(label): 2 -> \(Thread.current)")
                }
                
                target.sync {
                    DDLogDebug("\(label): 3 -> \(Thread.current)")
                }
            } else {
                target.async {
                    DDLogDebug("\(label): 1 -> \(Thread.current)")
                }
                
                target.async {
                    DDLogDebug("\(label): 2 -> \(Thread.current)")
                }
                
                target.async {
                    DDLogDebug("\(label): 3 -> \(Thread.current)")
                }
            }
            Thread.sleep(forTimeInterval: 1)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let block: () -> DispatchQueue = {
            switch indexPath.row {
            case 0: return DispatchQueue(label: "serial")
            case 1: return DispatchQueue(label: "concurrent", attributes: .concurrent)
            case 2: return DispatchQueue.global()
            case 3: return DispatchQueue.main
            default:
                return DispatchQueue.main
            }
        }
        
        let syncBlock: (_ current: DispatchQueue) -> Void = {current in
            
            let alert = UIAlertController(title: nil, message: "use sync?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "否", style: .cancel, handler: { (action) in
                self.taskIn(current: current, target: block(), false)
            }))
            alert.addAction(UIAlertAction(title: "是", style: .default, handler: { (action) in
                self.taskIn(current: current, target: block(), true)
            }))
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
        
        let alert = UIAlertController(title: nil, message: "选择当前队列", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "serial", style: .default, handler: { (action) in
            syncBlock(self.serialQ)
        }))
        alert.addAction(UIAlertAction(title: "concurrent", style: .default, handler: { (action) in
            syncBlock(self.concurrentQ)
        }))
        alert.addAction(UIAlertAction(title: "global", style: .default, handler: { (action) in
            syncBlock(self.globalQ)
        }))
        alert.addAction(UIAlertAction(title: "main", style: .default, handler: { (action) in
            syncBlock(DispatchQueue.main)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        navigationController?.present(alert, animated: false, completion: nil)

        tableView.deselectRow(at: indexPath, animated: false)
    }

}
