//
//  File.swift
//  
//
//  Created by Rake Yang on 2021/11/24.
//

import Foundation

class DoubleLinkedList: CustomStringConvertible {
    private var head: ListNode?
    private var tail: ListNode?
    var size: Int = 0
    
    func add(_ value: Int) {
        let node = ListNode(value, next: nil)
        if head == nil {
            head = node
            tail = node
        } else {
            node.last = tail
            tail?.next = node
            tail = node
        }
        size += 1
    }
    
    func remove(_ value: Int) {
        if value == head?.value {
            head?.next?.last = nil
            head = head?.next
            size -= 1
        } else {
            var prev = head
            var next = head?.next
            while next != nil {
                if next?.value == value {
                    prev?.next = next?.next
                    size -= 1
                    if tail?.value == next?.value {
                        tail = next
                    }
                    break
                }
                prev = next
                next = next?.next
            }
        }
    }
    
    var description: String {
        return "头部: \(head?.value) 尾部: \(tail?.value) size: \(size)"
    }
    
    class ListNode {
        var value: Int
        var last: ListNode?
        var next: ListNode?
        
        init(_ value: Int, next: ListNode?) {
            self.value = value
            self.next = next
        }
    }
}
