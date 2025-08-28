//: [Previous](@previous)

/*
 Hello team, Assignment 8
 In Swift playgorund have multiple examples to show usage of below:
 1. Initializers
   X  1.    Create a Book struct with a custom initializer that sets a default "Unknown" author if none is provided.
   X  2.    Build a Circle struct with two initializers: one for radius, another for diameter (delegating to radius).
   X  3.    Create a failable initializer for an Email struct that returns nil if the string doesn’t contain "@".
   X  4.    Make a Car class that has a designated initializer (brand, doors) and a convenience initializer (brand) that          defaults doors to 4.
   X  5.    Define a base class Shape with a required init(sides:) and implement it in a subclass Triangle.

  2. Error Handling , Do try catch ,  try , try!, throw , throws
   X  1.    Write a function sqrt(of:) throws that throws an error if input is negative.
   X  2.    Demonstrate do/try/catch by handling both safe and error cases of your functions.
   X  3.    Use try? with a throwing function to return an optional result safely.
   X  4.    Create a NetworkError enum and a fetchData(from:) throws function that validates a URL and simulates "Data from       URL" or throws errors.
 */

import Foundation

enum NetworkError: Error {
    case notFound, forbidden, internalError
    case urlInvalid
}

func fetchData(url:String) throws(NetworkError) -> String {
    if url.contains(try! Regex("http*.*")) {
        return "DMX 4040124"
    }
    else {
        throw(.urlInvalid)
    }
}

print("valid url: \(String(describing:try? fetchData(url: "https://youtube.com")))") //some
print("bad url: \((try? fetchData(url: "skjhdfksjh"))as Any)") // none

enum MathError: Error {
    case domainError
}

func sqrt(of:Double) throws(MathError) -> Double {
    guard of >= 0 else {
        throw .domainError
    }
    
    return of.squareRoot()
}

var res = try? sqrt(of: 16)
print(res as Any)
res = try? sqrt(of: -36)
print(res as Any)

do {
    try print("sqrt 2: \(sqrt(of: 2))")
}
catch {
    print(error)
}

do {
    try print("sqrt -8: \(sqrt(of:-8))")
}
catch(let e) {
    print(e)
}

class Shape {
    var nsides:Int
    required init() {
        nsides = 0
    }
}

class Triangle:Shape {
    required init() {
        super.init()
        nsides = 3
    }
}

class Car {
    var brand:String
    var doors:Int
    
    init(brand: String, doors: Int) {
        self.brand = brand
        self.doors = doors
    }
    
    convenience init(brand:String) {
        self.init(brand: brand, doors: 4)
    }
}

let car1 = Car(brand: "Chevrolet", doors: 2)
print(car1.doors)

let car2 = Car(brand: "Honda")
print(car2.doors)

struct EmailAddress {
    var name:String
    var domain:String
    
    init?(address:String) {
        let split = address.split(separator: "@")
        guard split.count == 2 else {
            return nil
        }
        
        self.init(name:String(split[0]), domain: String(split[1]))
        
    }
    
    init(name: String, domain: String) {
        self.name = name
        self.domain = domain
    }
    
}

print("valid email:   \(String(describing: EmailAddress(address: "a@b.com")))")
print("invalid email: \(String(describing: EmailAddress(address: "ab.com")))")
print("invalid email: \(String(describing: EmailAddress(address: "a@b.c@o@m")))")

struct Circle {
    var radius:Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    init(diameter:Double) {
        self.init(radius: diameter / 2.0)
    }
    
}

struct Book {
    var title:String
    var author:String
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
    
    init(title:String) {
        self.init(title:title, author: "Unknown")
    }
    
}
