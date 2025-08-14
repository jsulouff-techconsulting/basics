import Foundation

var greeting = "Hello, playground"

func bxi() -> Int {
    return 4
}

func outer() -> Bool {
    func inner() {
        
    }
    
    return false
}

a(u:1, false)

func a(u:Int, _ g:Bool) {
    
}

// double check logic on this one
func fib(_ n:Int) -> Int {
    var a = 1
    var b = 1
    
    for i in 1...n {
        let temp = a + b
        if i.isMultiple(of: 2) {
            b = temp
        }
        else {
            a = temp
        }
    }
    
    return max(a,b)
}

func bubble(_ arr: inout [Int]) {
    // are there slices in swift???
    func bubbleRecursion(left:ArraySlice<Int>, right:ArraySlice<Int>) {
        
        // make new half slices,
        // if odd number add alone
    }
}
