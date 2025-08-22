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
