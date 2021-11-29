//
//  File.swift
//  
//
//  Created by Rake Yang on 2021/11/24.
//

import Foundation

/// 单向链表: 就这?
class LinkedList<E: Equatable>: CustomStringConvertible {
    private var head: ListNode?
    private var current: ListNode?
    var size: Int = 0
    
    func add(_ value: Int) {
        let node = ListNode(value, nil)
        if head == nil {
            head = node
            current = node
        } else {
            current?.next = node
            current = node
        }
        size += 1
    }
    
    func remove(_ value: Int) {
        if value == head?.value {
            head = nil
            current = nil
            size -= 1
        } else {
            var prev = head
            var next = head?.next
            while next != nil {
                if next?.value == value {
                    prev?.next = next?.next
                    size -= 1
                    if current?.value == next?.value {
                        current = next
                    }
                    break
                }
                prev = next
                next = next?.next
            }
        }
    }
    
    func exchange(_ cur: ListNode?, _ prev: ListNode?, _ head: inout ListNode?) -> Void {
        let tmp = cur?.next
        if tmp == nil {
            if cur == nil {
                head?.next = nil
                head = prev
            } else {
                cur?.next = prev
                head?.next = nil
                head = cur
            }
            return
        }
        let next = tmp?.next
        tmp?.next = cur
        cur?.next = tmp
        if let prev = prev {
            cur?.next = prev
            tmp?.next = cur
        } else {
            cur?.next = nil
        }
        exchange(next, tmp, &head)
    }
        
    // 递归
    func reverseList(_ head: ListNode?) -> ListNode? {
        var h = head
        exchange(head, nil, &h)
        return h
    }
    
    // 迭代
    func reverseListV2(_ head: ListNode?) -> ListNode? {
        guard let head = head else { return nil}
        var root = ListNode(head.value)
        var next = head.next
        while next != nil {
            root = ListNode(next!.value, root)
            next = next?.next
        }
        return root
    }
    
    func reverse() {
        head = reverseList(head)
    }
    
    var description: String {
        return "头部: \(head?.value) 当前: \(current?.value) size: \(size)"
    }
    
    class ListNode {
        var value: Int
        var next: ListNode? //不能使用struct（递归引用，导致size无限大小）
        
        init(_ value: Int, _ next: ListNode? = nil) {
            self.value = value
            self.next = next
        }
    }
}
