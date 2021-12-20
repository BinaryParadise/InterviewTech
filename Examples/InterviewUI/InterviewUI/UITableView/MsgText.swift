//
//  MsgText.swift
//  InterviewUI
//
//  Created by Rake Yang on 2021/12/16.
//

import Foundation

class MsgText: MsgBase {
    var text: String
    
    init(text: String, from: Int) {
        self.text = text
        super.init(from: from, name: "\(from)-name", avatar: "")
    }
}
