//: [Previous](@previous)

import Foundation

/*
 
 Assignment 3
 In Swift playgorund have multiple examples to show usage of below:
 1.tuples- differnt types
 2.Loops (for loop , while loop, repeat while)
 3.Conditional statements
 4.Optionals and Optional Bindings
 5.for Loops:
 Print numbers from 10 down to 1 using a stride.
  Given [1,2,3,4,5,6], print only even numbers using for case/where.
  Remove all odd numbers from an array safely while iterating.
  Simulate retrying an operation up to 5 times with a while loop, then print success/failure.
 6.Tuples
     a.    Create a tuple to store a student’s name, roll number, and marks. Print them using both positional and named access.
     b.    Write a function divide(_:by:) that returns both the quotient and remainder as a tuple.
     c.    Write a function returning a tuple (success: Bool, message: String) for login validation.
 Conditional statements
 Write an if that prints “Even” if a number is even, else “Odd”
 Use switch to print the season for a given month number.
 Validate a username with guard so it’s at least 5 characters.
 
 */

func divide(_ val:Float, by:Float) -> (Float, Float) {
    return (
        val / by,
        (val.truncatingRemainder(dividingBy: by))
    )
}

func printNumberEvenness(_ n:Int) {
    if n%2 > 0 {
        print("Odd")
    }
    else {
        print("Even")
    }
}

func validateUserName(_ un:String) -> Bool {
    if un.count >= 5 {
        return true
    }
    else {
        return false
    }
}

func monthNumberToSeason(month:Int) -> String? {
    switch month {
    case 12:
        fallthrough
    case 1..<4:
        return "Winter"
    case 4..<6:
        return "Spring"
    case 6..<9:
        return "Summer"
    case 9..<12:
        return "Autumn"
    default:
        // not a valid month
        return nil
    }
}

let studentTuple = (name:"Ryan", rollNumber:67, gpa:3.48)
print("[using named access] Student \(studentTuple.name) is roll number \(studentTuple.rollNumber) and has a gpa of \(studentTuple.gpa)")
print("[using named access] Student \(studentTuple.0) is roll number \(studentTuple.1) and has a gpa of \(studentTuple.2)")

var greeting = "Hello, playground"
let arrayBasic = [12, 13, 19, 191, 0xFC, 82, 904, 129]

for idx in stride(from:10, to: 0, by: -1) {
    print("Index: \(idx)")
}

var given = [1,2,3,4,5,6]

var index = 0
for i in given {
    if i % 2 > 0 {
        //odd
        given.remove(at:index)
        index -= 1
    }
    else {
        //even
        print(i)
        index += 1
    }
}

var loginAttempts = 0
var loginSucceeded = false
loginlp: while loginAttempts < 5 {
    if Bool.random() {
        loginSucceeded = true
        break loginlp
    }
    else {
        print("Login attempt rejected.")
    }
    loginAttempts += 1
}
if loginSucceeded {
    print("Login succeeded.")
}
else {
    print("Login failed.")
}

let monoTypeTuple = (12,8,17) // tuples can have one type
let manyTypeTuple = (12, "", false) // or many types in them
let tupleWithNames = (uName:"john", lastLogin:"July 10th")

typealias Vector3 = (Float, Float, Float) // tuples can also be used to make type aliases

func removeWhiteSpace(_ str:inout String) {
    var res = ""
    res.reserveCapacity(str.count)
    for chara in str {
        if !chara.isWhitespace {
            res.append(chara)
        }
    }
    str = res // are there move semantics in swift?
}

var testString = "  there are    a few types of whitespace\n in this string"
removeWhiteSpace(&testString)
print(testString)

func emptyArrayOneAtATime(_ arr:inout [Int]) {
    while !arr.isEmpty {
        if let popped = arr.popLast() {
            print("popped: \(popped)")
        }
    }
}

func emptyArrayAtLeastOneMember(_ arr:inout [Int]) {
    repeat {
        if let popped = arr.popLast() {
            print("popped: \(popped)")
        }
    } while arr.isEmpty
}

var demoArray = arrayBasic

emptyArrayOneAtATime(&demoArray)

//: [Next](@next)
