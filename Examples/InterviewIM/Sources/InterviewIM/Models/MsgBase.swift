//
//  MsgBase.swift
//  InterviewUI
//
//  Created by Rake Yang on 2021/12/16.
//

import Foundation

class MsgBase: Codable {
    var id: Int64
    var uid: Int64
    var gid: Int64?
    var content: String
    var timestamp: TimeInterval
}
