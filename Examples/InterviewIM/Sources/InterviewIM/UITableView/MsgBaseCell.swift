//
//  MsgBaseCell.swift
//  InterviewUI
//
//  Created by Rake Yang on 2021/12/15.
//

import Foundation
import UIKit

class MsgBaseCell: UITableViewCell {
    let avatarView = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(hex: 0xF2F2F2)
        avatarView.cornerRadius = 4
        avatarView.backgroundColor = .systemPink
        contentView.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with data: MsgBase?) {
        
    }
    
    class func cellHeight(for data: MsgBase?) -> CGFloat {
        return 50
    }
}
