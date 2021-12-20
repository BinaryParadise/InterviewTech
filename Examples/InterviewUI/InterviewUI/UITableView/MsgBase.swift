//
//  MsgBase.swift
//  InterviewUI
//
//  Created by Rake Yang on 2021/12/16.
//

import Foundation

class MsgBase {
    var from: Int
    var name: String
    var avatar: String
    
    init(from: Int, name: String, avatar: String) {
        self.from = from
        self.name = name
        self.avatar = avatar
    }
}
