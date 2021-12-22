//
//  MsgTextCell.swift
//  InterviewUI
//
//  Created by Rake Yang on 2021/12/15.
//

import Foundation
import UIKit

class MsgTextCell: MsgBaseCell {
    let msgLabel = UILabel()
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let container = UIView()
        container.layer.cornerRadius = 8
        container.backgroundColor = .white.withAlphaComponent(0.9)
        contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.left.equalTo(avatarView.snp.right).offset(8)
            make.top.equalTo(avatarView)
            make.right.lessThanOrEqualTo(contentView.snp.centerX).multipliedBy(1.5)
            make.bottom.equalToSuperview().offset(-12)
        }
        msgLabel.numberOfLines = 0
        msgLabel.textColor = UIColor(hex: 0x999999)
        container.addSubview(msgLabel)
        msgLabel.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        }
    }
    
    override func config(with data: MsgBase?) {
        guard let data = data else {
            return
        }
        
        msgLabel.text = data.content
    }
    
    override class func cellHeight(for data: MsgBase?) -> CGFloat {
        guard let data = data else {
            return 64
        }
        let r = data.content.nsString.size(withAttributes: [.font: UIFont.systemFont(ofSize: 15)])
        return max(r.height + 24, 64)
    }
}
