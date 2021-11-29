import CocoaLumberjackSwift

public struct AlgorithmTech {
    public static var shared = AlgorithmTech()
    var linked: LinkedList<Int> = LinkedList()
    public init() {        
        
    }
    
    public func run() {
        linked.add(1)

        linked.add(2)

        linked.add(3)
//
//        linked.add(4)
//
//        linked.add(5)
        
        //linked.remove(3)
        
        linked.reverse()
        
        DDLogInfo("\(linked)")
        
        var lk = DoubleLinkedList()
        
        lk.add(1)
        lk.add(2)
        lk.add(3)
        lk.add(4)
        lk.add(5)
        
        DDLogInfo("\(lk)")

    }
}
