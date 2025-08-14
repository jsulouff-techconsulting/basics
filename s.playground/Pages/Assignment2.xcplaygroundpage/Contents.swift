/*
 Assignment 2
 In Swift playgorund have multiple examples to show usage of below:
 1.functions- differnt types
 2.collections- Array, set, dictionary
 3.Write a function square(number:) that returns the square of an Int.
 4.Create a function greet(user:atTime:) that prints different messages based on the time.
 5.Build a function merge(arrays:) that takes variadic [Int] arrays and returns a single merged sorted array.
 6.Create an array of strings for your top 3 favorite apps and print them in reverse order.
 Use a set to store unique programming languages from a list containing duplicates.

 Create a dictionary mapping product IDs (String) to stock counts (Int). Update stock for a product.

 Tomorrow in classroom you need to explain your written code, so dont rush in finishing the assignment, take your time and do it throughly.
 Once Completed this and push to code to githib and share link of it in this group itself.

 */

import Foundation

typealias Vector2 = (Float, Float)

func square(_ n:Int) -> Int {
    return n * n
}

func merge(arrays:[Int]...) -> [Int] {
    var elemCount = 0
    for array in arrays {
        elemCount += array.count
    }
    
    var finalArray:[Int] = []
    finalArray.reserveCapacity(elemCount)
    
    for array in arrays {
        for v in array {
            finalArray.append(v)
        }
    }
    
    finalArray.sort()
    
    return finalArray
    
}

print(merge(arrays: [12,13], [1, 25, 6], [10, 12, 11]))

func greet(user:String, atTime:String) {
    
    // Try to get the hour for a time of day appropriate greeting.
    func getTimeGreeting(time:String) -> String? {
        // find the colon to denote time of day.
        if let colon = time.firstIndex(of: ":") {
            let hour = time[time.startIndex..<colon];
            
            if let hour_v = Int(hour) {
               
                    if hour_v < 12 {
                        return "Good morning"
                    }
                    else if hour_v < 18 {
                        return "Good afternoon"
                    }
                    else if hour_v < 24 {
                        return "Good evening"
                    }
                    else {
                        return nil
                    }
                
            }
            else {
                return nil // nan -> bail
            }
            
        }
        else {
            return nil // no colon -> bail
        }
        
        
    }
    
    // define a message based on whether the time based greeting extractor works
    let message:String
    
    if let greeting = getTimeGreeting(time: atTime) {
        message = "\(greeting), \(user)"
    }
    else {
        message = "Hello, \(user), the time is \(atTime)"
    }
    
    print(message)
    
}

greet(user: "Jjim", atTime: "14:32")   //  afternoon
greet(user: "Mike", atTime: "spinach") //  should print default text
greet(user: "Melissa", atTime: "4:00") //  morning
greet(user: "Emily", atTime: "19:00")  //  evening

func addVector(_ a:Vector2, _ b:Vector2) -> Vector2 {
    return (a.0 + b.0 , a.1 + b.1)
}

func mulEqualsVector(a:inout Vector2, scalar:Float) {
    a.0 *= scalar
    a.1 *= scalar
}

func VectorZero() -> Vector2 {
    return (0,0);
}

func VectorUnit(degrees:Float) -> Vector2 {
    return (cos(degrees), sin(degrees))
}

let arr1 = [1,4,6,8]
let dict1 = ["one" : 1, "two" : 2, "three": 3]
let set1 = ["p1", "p2", "p8"]

var favApps = ["Newpipe","Fedilab","ElementX"]

print("My favorite apps in reverse order are \(Array<String>(favApps.reversed()))")

var languages:Set<String> = ["Rust", "Ruby", "D", "Odin", "D" , "C", "C++", "Rust"]

typealias ProductId = String

let productsCount:[ProductId:Int] = [
    "pretzels" : 14,
    "mustard"  : 10,
    "hot dogs" : 85,
]
