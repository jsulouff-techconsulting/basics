//: [Previous](@previous)

/*
 Assignment 10 — Swift Playground

 Capture List
   X  •    Create a counter that starts from an initial start value.
   X  •    Assign a closure that captures start by value (capture list) and prints it each time it runs.
   X  •    Change the outer start afterward and prove the closure still prints the original captured value.
   X  •    Create a second closure that captures a mutable local variable by value ([copy = local]) and show the original can change without affecting copy.

 Closure with Capture List for weak self
    X •    Design a Downloader (or TimerOwner) class with a closure property onFinish.
    X •    Assign onFinish using [weak self] so the object can deallocate if the user “navigates away”.
    X •    Show: with weak capture → object deallocates; without it → retain cycle risk.

 GCD —
 Show with differnt examples how to use
 X 1.Main Queue
 X 2.Custom Queue- serial and concurrent queue usage
 X 3.Global queues and use of differnt QOS
 */

DispatchQueue.main.async() {printFactorsOf(47)}
DispatchQueue.main.async() {printFactorsOf(455)}
DispatchQueue.main.async() {printFactorsOf(6000)}

let nQueue = DispatchQueue(label:"primefactors")
nQueue.async() {printFactorsOf(12)}
nQueue.sync() {printFactorsOf(46)}

DispatchQueue.global(qos:.userInitiated).async() {printFactorsOf(812)} // high priority
DispatchQueue.global().async() {printFactorsOf(818)}
DispatchQueue.global().async() {printFactorsOf(820)}

class Downloader {
    var onFinish: (()->Void)?
    var completionCode:Int = 0
    
    init() {
        
        self.onFinish = nil
        self.onFinish = {
            [weak self] in
            self?.completionCode = 4
        }
    }
    
    deinit {
        print("Downloader freed.")
    }
    
    func setMemoryLeak() {
        self.onFinish = {
            self.completionCode = 4
        }
    }
    
}

var dlSafe:Downloader? = Downloader()
var dlUnsafe:Downloader? = Downloader()
dlUnsafe!.setMemoryLeak()

dlSafe = nil
dlUnsafe = nil



func makeCounter(start v:Int) -> () ->Int  {
    var counter = v
    return {
        [v] in
        var counterState = v // nested tuple nightmare
        return {
            counterState += 1
            return counterState
        }
    } ()
}

func grabValueOnBuildClosure(value:Int) -> ()->Int {
    return {
        [value] in
        return value
    }
}

let fourClosure = grabValueOnBuildClosure(value: 4)
let fiveClosure = grabValueOnBuildClosure(value: 5)

print("four: \(fourClosure()), five:\(fiveClosure())")

import Foundation

var greeting = "Hello, playground"

// this will be our busywork function
func primeSieve(_ value: Int) -> [Int] {
    let rangeLimit = value / 2
    
    func isFactor(value:Int, factorOf:Int) -> Bool {
        return (factorOf % value == 0)
    }
    
    var res = Array(
        (2...rangeLimit).filter() {
            return isFactor(value: $0, factorOf: value)
        }
    )
    res.append(1); res.append(value)
    return res
}

func printFactorsOf(_ value: Int) {
    print("Printing the factors of \(value)...")
    print("The factors of \(value) are \(primeSieve(value))")
}

print(primeSieve(400))

//: [Next](@next)
