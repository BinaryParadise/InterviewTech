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

class ConcurrentTableViewController: UIViewController {
    let tableView = UITableView(frame: .zero, style: .plain)
    var msgs: [MsgBase] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(hex: 0xF2F2F2)
        if #available(iOS 13.0, *) {
            tableView.automaticallyAdjustsScrollIndicatorInsets = false
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
        for i in 0...1000 {
            msgs.append(MsgText(text: UUID().uuidString.toSlug(), from: i))
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.scrollToBottom(animated: false)
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
