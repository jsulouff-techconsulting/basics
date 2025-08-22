/*
 Assignment  7
 In Swift playgorund have multiple examples to show usage of below:
 1.Higher order functions
     1.    Use map to convert an array of Celsius temps to Fahrenheit.
     2.    Use filter to extract all odd numbers from [1...20].
     3.    Use reduce to multiply all numbers in [1,2,3,4].
     4.    Use sorted to arrange names alphabetically.
     5.    Given a list of sentences, use flatMap to break them into words.

  2. Generic
     1.     Create Stack for String using Genrics
     2.    Write a generic function maxValue<T: Comparable>(_ a: T, _ b: T) -> T.
     3.    Create a generic Queue<T> type with enqueue and dequeue.
     4.    Write a generic function to reverse any array.
     5.    Show use of Genrics for enum
     5.    Show use of Genrics for Class


 3. AssociatedType
 * Define a protocol QueueProtocol with an associated type Element.
 * Implement IntQueue and StringQueue.
 * Show 2 differnt examples of AssociatedType usages
 */

let sentences = ["I have it!", "That's not right", "you cant do that.", "I'll allow it"]

print(sentences.flatMap( {
    sentence in
    return sentence.split(separator: " ")
}
    ))

let names = ["paul", "eric", "lisa", "simon", "aaa123"]
let namesSorted = names.sorted()
print(namesSorted)

let multarray = Array([1,2,3,4])

// idgi, this is exactly what the docs show
//
let multd = multarray.reduce(1, { x,y in
    x * y
    })
print(multd)

let celciusTemps = [12.64, 98.5, -5, 24]
let fahrenheitTemps = celciusTemps.map() {
    (val:Double) -> Double in
    val * ( 9.0/5.0 ) + 32
}

print(fahrenheitTemps)

let arr1 = Array(1...20)
let arr1Filter = arr1.filter() {
    val in
    val & 1 == 1
}
print(arr1Filter)

class Vector2<T:Numeric> {
    public var x:T,y:T = 0
    init(x: T, y: T) {
        self.x = x
        self.y = y
    }
}

enum Option<T> {
    case some(T)
    case none
}

func reverseArray<T>(array:[T]) -> [T] {
    return Array<T>(array.reversed())
}

struct Queue<T> {
    var pool:[T]
    
    private mutating func shiftRight() {
        for idx in 1..<pool.count {
            pool[idx - 1] = pool[idx]
        }
        pool.popLast()
    }
    
    mutating func popBack() -> T? {
        if pool.count > 0 {
            return pool.popLast()
        }
        else {
            return nil
        }
    }
    
    mutating func popFront() -> T? {
        if pool.count > 0 {
            let value = pool.first
            shiftRight()
            return value
        }
        else {
            return nil
        }
    }
    
}


func maxValue<T:Comparable>(_ values:T...) -> T? {
    var max = values.first!
    
    for value in values {
        if value > max {
            max = value
        }
    }
    
    return max;
}

print(maxValue(1,4,5,66,3637,0xffff)!)

struct Stack<T> {
    var stack:[T] = []
    
    mutating func push(new:T) {
        stack.append(new)
    }
    
    mutating func pop() -> T? {
        return stack.popLast()
    }
    
    func top() -> T? {
        return stack.first
    }
    
    init(array:[T]) {
        for value in array {
            self.push(new: value)
        }
    }
    
    func unwind(method:(T) -> Void) {
        for value in self.stack.reversed() {
            method(value)
        }
    }
    
}

let stringArray = ["Hello", "How are", "you", "doing"]

Stack(array: stringArray).unwind(method: { print($0) })

// A node in a binary tree could have anything stored in it, but will always have a left and right
protocol BinaryTreeNode {
    associatedtype NodeData
    func left() -> Self?
    func right() -> Self?
    func node() -> NodeData
}

protocol QueueProtocol {
    associatedtype Element
    func add(next:Element)
    func pop() -> Element
    func len() -> Int
}

class IntQueue : QueueProtocol {
    typealias Element = Int
    var queue:[Int] = []
    func len() -> Int {
        return queue.count
    }
    func add(next: Int) {
        queue.append(next)
    }
    func pop() -> Int {
        let popped = self.queue[0]
        self.shiftRight()
        return popped
    }
    
    private func shiftRight() {
        for idx in 1..<self.queue.count {
            self.queue[idx - 1] = self.queue[idx]
        }
        self.queue.popLast()
    }
}

class StringQueue : QueueProtocol {
    typealias Element = String
    var queue:[String] = []
    
    func len() -> Int {
        return queue.count
    }
    
    func add(next: String) {
        queue.append(next)
    }
    
    func pop() -> String {
        let popped = self.queue[0]
        self.shiftRight()
        return popped
    }
    
    private func shiftRight() {
        for idx in 1..<queue.count {
            self.queue[idx - 1] = self.queue[idx]
        }
    }
}

/*
 // Doesnt wanna work
func isInOrder<T:QueueProtocol> where QueueProtocol.Element: Comparable (queue:T) -> Bool {
    var previous = queue.pop()
    while queue.len() > 0 {
        if previous > queue.pop() {
            return false
        }
    }
    return true
}
*/
