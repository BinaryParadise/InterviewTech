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
    
    func queue(row: Int) -> Void {
        let block: () -> DispatchQueue = {
            switch row {
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
    }
    
    func _NSThread(row: Int) {
        // 需要手动管理生命周期
        let thread = Thread(target: self, selector: #selector(onThread(_:)), object: nil)
        thread.start()
    }
    
    @IBAction func onThread(_ sender: Any) {
        DDLogDebug("isMainThread: \(Thread.current.isMainThread)")
        DDLogDebug("name: \(Thread.current.name)")
    }
    
    func _NSOperation(row: Int) {
        if row == 0 {
            let oq = OperationQueue()
            let op1 = BlockOperation {
                DDLogInfo("创建订单 -> \(Thread.current)")
            }
            
            let op2 = BlockOperation {
                DDLogInfo("已签收 -> \(Thread.current)")
            }
            
            let op3 = BlockOperation {
                DDLogInfo("订单完成 -> \(Thread.current)")
            }
            
            let op4 = BlockOperation {
                DDLogInfo("已发货 -> \(Thread.current)")
            }
            
            let op5 = BlockOperation {
                DDLogInfo("配送中 -> \(Thread.current)")
            }
            
            op3.addDependency(op2)
            op2.addDependency(op5)
            op5.addDependency(op4)
            op4.addDependency(op1)
            
            oq.addOperation(op1)
            oq.addOperation(op2)
            oq.addOperation(op3)
            oq.addOperation(op4)
            oq.addOperation(op5)
        } else if row == 1 {
            let op1 = BlockOperation {
                DDLogDebug("单独Operation -> \(Thread.current)")
            }
            op1.start()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.section == 0 {
            queue(row: indexPath.row)
        } else if indexPath.section == 1 {
            _NSThread(row: indexPath.row)
        } else if indexPath.section == 2 {
            _NSOperation(row: indexPath.row)
        }
    }

}
