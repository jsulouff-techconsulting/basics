import Foundation

/*
 Assignment 6
 In Swift playgorund have multiple examples to show usage of below:
 1.Closures and its types

  Write a closure that multiplies two Ints and assign it to a variable.
  Implement makeCounter() that returns a closure incrementing an internal count.
  Build performLater(_:) using @escaping and DispatchQueue to run after 1s.
  Write a function retry(times:action:) that executes an escaping closure up to N times until it returns true.
 */


let retryAttempt:@Sendable () -> Bool = { () -> Bool in
    return Bool.random()
}

// What does it mean to be escaping outside of a threading context?
func retry(times:Int, action:@escaping @Sendable () -> Bool) {
    let queu = DispatchQueue(label: "retry.queue")
    retrylp: for _ in 0..<times {
        if action() {
            print("Success!")
            break retrylp
        }
        else {
            print("failure.")
        }
    }
}

retry(times: 12, action: retryAttempt);

// Non escaping, the default for closures.
// Closures allow you to pass behavior as a value
let plus2 =  { (value:Int) -> Int in
        return value + 2
}

func templateTest<T,RT> (argument:T, closure:(T) -> RT) -> RT {
    return closure(argument);
}

func operateOnArray<T>(array:inout [T], operation:(T) -> T) {
    for (index, value) in array.enumerated() {
        array[index] = operation(value);
    }
}

let toString = { (v:Int) -> String in
    return String(v)
}

print((templateTest(argument: 14, closure: toString)))

let sampleIntArray = [12, 14, 1, 7, 999, 84, 2025]
var demo1 = sampleIntArray

operateOnArray(array: &demo1, operation: plus2)
print(demo1)

let mulClosure = { (v1:Int, v2:Int, out:inout Int) in
    out = v1 * v2
}

// I think this is what he means?
// A closure cannot have static variables in it.
// I don't think swift allows mutating static values at all, for good reason (thread safety)

// I wasnt aware of closures ability to capture values
func makeCounter() -> (inout Int) -> Int {
    var counter = 0
    return {
        (value:inout Int) in
        counter += 1
        return counter
    }
}

let delayedExecution = {
    print("This executes after 1 second.")
}
// sendable
func performLater(method:@escaping @Sendable () -> Void) {
    DispatchQueue(label: "delay").asyncAfter(deadline: .now() + 1, execute: method)
    print("thread dispatched.")
}
