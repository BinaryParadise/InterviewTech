//
//  ConcurrentTableViewController.swift
//  InterviewUI
//
//  Created by Rake Yang on 2021/12/15.
//

import Foundation
import UIKit
import SnapKit
import SwifterSwift
import CocoaLumberjackSwift
import InterviewUIComponent
import MJRefresh

enum GenerateMode {
    case single
    case batch
    case transaction
}

class ConcurrentTableViewController: UIViewController {
    let tableView = AutomaticUITableView(frame: .zero, style: .plain)
    var msgs: [MsgBase] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(moreAction))
        
        tableView.backgroundColor = UIColor(hex: 0xF2F2F2)
        if #available(iOS 13.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalTo(topLayoutGuide.snp.top)
            }
            make.left.bottom.right.equalToSuperview()
        }
        
        tableView.register(cellWithClass: MsgTextCell.self)
        
        // 下拉刷新
        tableView.mj_header = RefreshSeamlessHeader(refreshingBlock: {
            self.fetchData()
        })
        
        fetchData()
        
        let tm = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { t in
            let c = IMDBManager.shared.count()
            DispatchQueue.main.async {
                self.title = "\(c)"
            }
        }
        RunLoop.current.add(tm, forMode: .common)
        tm.fire()
    }
    
    func fetchData(state: RefreshState = .first) {
        IMDBManager.shared.query(pageNum: 1) { [weak self] r in
            guard let self = self else { return }
            if let r = r, let m = try? JSONDecoder().decode([MsgBase].self, from: JSONSerialization.data(withJSONObject: r, options: .fragmentsAllowed)) {
                self.msgs.append(contentsOf: m)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if m.count < pageSize {
                        self.tableView.mj_header = nil
                    } else {
                        self.tableView.mj_header?.endRefreshing()
                    }
                    self.tableView.reloadData()
                    if state == .first {
                        self.scrollBottom()
                    }
                }
            }
        }
    }
    
    @IBAction func moreAction() {
        let vc = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        vc.addAction(UIAlertAction(title: "生成消息（单条）", style: .default, handler: { a in
            self.generateTestMessages()
        }))
        vc.addAction(UIAlertAction(title: "生成消息（批量）", style: .default, handler: { a in
            self.generateTestMessages(mode: .batch)
        }))
        vc.addAction(UIAlertAction(title: "生成消息（事务）", style: .default, handler: { a in
            self.generateTestMessages(mode: .transaction)
        }))
        vc.addAction(UIAlertAction(title: "解析对话数据集", style: .default, handler: { a in
            self.transformTalkXml()
        }))
        vc.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func scrollBottom() {
        if msgs.count < 2 {
            return
        }
        tableView.safeScrollToRow(at: IndexPath(row: msgs.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    func generateTestMessages(mode: GenerateMode = .single) {
        let g = DispatchGroup()
        let d = Date()
        for i in 0..<6 {
            DispatchQueue.global().async(group: g, execute: .init(block: {
                print("进行中\(i): \(mode)")
                switch mode {
                case .single:
                    for _ in 0..<5000 {
                        IMDBManager.shared.insert(sql: "INSERT INTO Messages(uid, type, content) Values(\(20210880), 0, '\(i)\(UUID().uuidString.toSlug())')", args: nil)
                    }
                case .batch:
                    //20次，每次500条
                    for _ in 0..<10 {
                        var batchSQL = "INSERT INTO Messages(uid, type, content) "
                        for j in 0..<500 {
                            if j > 0 {
                                batchSQL.append("UNION ALL\n")
                            }
                            batchSQL.append("Values(\(20210880), 0, '\(i)\(UUID().uuidString.toSlug())')")
                        }
                        batchSQL.append(";")
                        IMDBManager.shared.insert(sql: batchSQL, args: nil)
                    }
                case .transaction:
                    //20次，每次500条
                    for _ in 0..<10 {
                        IMDBManager.shared.beginTransaction { db in
                            for j in 0..<500 {
                                try? db.executeUpdate("INSERT INTO Messages(uid, type, content) Values(\(20210880), 0, '\(j)\(UUID().uuidString.toSlug())')", values: nil)
                            }
                        }
                    }
                }
            }))
        }
        g.notify(queue: .global()) {
            print("测试消息生成完成，耗时: \(Date().timeIntervalSince1970 - d.timeIntervalSince1970)")
        }
    }
    
    func transformTalkXml() {
        let bundle = Bundle(path: "\(Bundle(for: MsgBase.self).bundlePath)/InterviewIM_InterviewIM.bundle")
        if let path = bundle?.path(forResource: "smsCorpus_zh_2015.03.09.json", ofType: nil) {
            do {
                let talks = try JSONSerialization.jsonObject(with: Data(contentsOf: URL(fileURLWithPath: path)), options: .fragmentsAllowed) as? [String]
                IMDBManager.shared.beginTransaction { db in
                    for item in (talks ?? []).reversed() {
                        try? db.executeUpdate("INSERT INTO Messages(uid, type, content) Values(\(20210880), 0, \"\(item)\")", values: nil)
                    }
                }
            } catch {
                print("\(error)")
            }
            
        }
    }
}

extension ConcurrentTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MsgTextCell.self, for: indexPath)
        cell.config(with: msgs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ConcurrentTableViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DDLogWarn("contentOffset.y: \(scrollView.contentOffset.y)")
    }
}
