//
//  HitTestView.swift
//  InterviewUI
//
//  Created by Rake Yang on 2021/12/20.
//

import Foundation
import UIKit

@IBDesignable
class HitTestView: UIView {
    @IBInspectable var title: String?
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let r = super.point(inside: point, with: event)
        print("\(#function) \(title ?? "U") -> \(r)")
        return r
    }
}
