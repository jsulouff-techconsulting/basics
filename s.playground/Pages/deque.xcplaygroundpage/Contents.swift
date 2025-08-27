typealias OrderedArena<T> = DoublyLinkedList<T>;
struct DoublyLinkedList<T> {
    struct Node {
        var value: T
        var next:Int?
        var previous:Int?
        
        init(value: T) {
            self.value = value
            self.next = nil
            self.previous = nil
        }
        
        // track generation number and just get nth on a change?
        
    }
    
    struct DlListIterator {
        var idx:Int
        
    }
    
    
    // todo: add ordered/unordered iterator
    
    
    var arena:[Node?] = []
    var first:Int? = nil
    var last:Int? = nil
    
    var layoutGenerationNumber:Int = 0
    
    var holes = 0
    var holeRatioBeforeDefrag:Double = 0.5
    
    private func freeNode(index:Int) {
        guard let node = arena[index] else {
            debugPrint("Tried to dealloc nonexistent index \(index)")
            return;
        }
        
        
        
        let previous = arena[node.previous!]!
        let next = arena[node.next!]!
        
        
        
    }
    
    private func countHoles() -> Int {
        return 0//todo
    }
    
    private func allocNode(data:T) -> Int {
        for (idx, node) in arena.enumerated() {
            if node == nil {
                // we dont setup the next/previous ptrs in this function
                arena[idx] = Node(value:data)
                return idx
            }
        }
        
        // No free slots, need to realloc
        let nSize = arena.count + 1
        realloc(newsize: nSize)
        return nSize
    }
    
    // run whenever we have to reallocate
    private func realloc(newsize:Int? = nil) {
        // iterate through list, shove them in in order since we need to copy them anyway
        
        // when we're out of values to put, fill the rest of the arena will nil
        
        layoutGenerationNumber += 1
    }
    
    init(capacity:Int) {
        
    }
    
}

class Dequeue<T> {
    var table:[T?] = []
    
    var qFront = 0
    var qback = 0
    
    func reserveCapacity(minimumSize min:Int) {
        self.table.reserveCapacity(min)
    }
    
    private enum Side {
        case front, back
    }
    
    private func findNextSlot(side:Side) -> Int? {
        switch side {
            case .front:
                // start from qfront, and go back (looping) until it hits the back
                var idxCandidate:Int = self.qFront - 1 % self.table.count
                while idxCandidate != self.qback {
                    
                    if self.table[idxCandidate] == nil {
                        return idxCandidate
                    }
                    
                    idxCandidate -= 1
                    idxCandidate %= table.count
                }
            
            case .back:
                var idxCandidate:Int = self.qback + 1 % self.table.count
                while idxCandidate != self.qback {
                    
                    if self.table[idxCandidate] == nil {
                        return idxCandidate
                    }
                    
                    idxCandidate += 1
                    idxCandidate %= self.table.count
                }
            
            
        }
        return nil
    }
    
    func pushBack(item:T) {
        if let idx = findNextSlot(side: .back) {
            
        }
        else {
            
        }
    }
    
    func pushFront(item:T) {
        
    }
    
    
}
