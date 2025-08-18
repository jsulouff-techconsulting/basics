//: [Previous](@previous)
/*
 
 Assignment 4
 In Swift playgorund have multiple examples to show usage of below:
 1.Enum- differnt types, functions and properties in enums
 X Create an enum for the four seasons and print a message for each.
 X Define an enum LoginState with cases loggedIn(user: String) and loggedOut.
 X Create an enum with raw values for HTTP methods (GET, POST, etc.).
 X Add a computed property to an enum Planet returning its order from the sun.
 X Iterate over all cases of an enum TransportMode using CaseIterable.

 2.Class- Oops concept
 X Create a class Car with properties make and model, and a method drive().
 X Build an Employee class inheriting from Person with an extra property employeeID.
 X Implement a class BankAccount with deposit and withdraw methods.
 X Create a Shape base class and Triangle/Square subclasses overriding an area() method.
   
 3.Classes refrence type usage
 X Demonstrate reference semantics by assigning one instance to multiple variables and modifying it.

 4.Structs
 X Create a struct Book with properties title and author and a method description().
 X Make a struct Temperature with a computed property converting Celsius to Fahrenheit
 X Build a struct Vector2D with methods to add and subtract two vectors
 
 */
import Foundation

enum Seasons {
    case winter,spring,summer,autumn
    
    func genMessage() -> String {
        switch self {
        case .winter:
            return "Happy winter! Stay warm!"
        case .spring:
            return "It's spring! Go smell some flowers."
        case .autumn:
            return "It's autumn! Get yourself some apple cider."
        case .summer:
            return "It's summer! Try to stay cool."
        }
    }
}

print(Seasons.autumn.genMessage())
print(Seasons.spring.genMessage())
print(Seasons.winter.genMessage())
print(Seasons.summer.genMessage())

enum LoginState {
    case loggedIn(uname:String)
    case loggedOut
}

enum HttpResponse: Int {
    case ok = 200
    case notFound = 404
    case serverError = 503
}

enum Planet {
    case mercury, venus, earth, mars, saturn, jupiter, neptune, uranus, pluto
    
    func getOrderFromSun() -> Int {
        switch self {
            case .mercury:
                return 1
            case .venus:
                return 2
            case .earth:
                return 3
            case .mars:
                return 4
            case.saturn:
                return 5
            case .jupiter:
                return 6
            case .neptune:
                return 7
            case .uranus:
                return 8
            case .pluto:
                return 9
            }
    }
}

enum TransportMethods: CaseIterable {
    case car, bus, bike, train
}

for mode in TransportMethods.allCases {
    print("You could take a \(mode) to work")
}

class Car {
    var make, model:String
    
    init(make: String, model: String) {
        self.make = make
        self.model = model
    }
    
    func drive() {
        print("Drove the \(self.make) \(self.model)")
    }
}

print(Car(make: "Chevy", model: "Malibu").drive())

class Person {
    var name:String = "Anonymous"
    var DOB:Date = Date.distantPast
    
    init(name: String, DOB: Date) {
        self.name = name
        self.DOB = DOB
    }
    
}

class Employee: Person {
    var employeeID:Int = 0
}

class BankAccount {
    var balance:Int
    
    func withdraw(amount:Int) -> Int? {
        if amount <= balance {
            balance -= amount
            return amount
        }
        else {
            //decline
            return nil
        }
    }
    
    func deposit(amount:Int) {
        self.balance += amount
    }
    
    func getBalance() -> Int {
        return balance
    }
    
    init(balance: Int) {
        self.balance = balance
    }
    
}

class Shape {
    func area() -> Float {
        return 0.0
    }
}

class Square: Shape {
    var base,height:Float
    
    init(base: Float, height: Float) {
        self.base = base
        self.height = height
    }
    
    override func area() -> Float {
        return self.base * self.height
    }
    
}

class Triangle: Shape {
    public var base, height:Float
    
    init(base: Float, height: Float) {
        self.base = base
        self.height = height
    }
    
    override func area() -> Float {
        return self.base * self.height * 0.5
    }
    
}

struct Book {
    var title:String = "Untitled"
    var author:String = "Anonymous"
    
    func description() -> String {
        return "The book \(self.title) was written by \(self.author)"
    }
}

struct Temperature {
    var temp_celcius:Float
    
    private static func from_fahrenheit(_ v:Float) -> Float {
        return (Float(v)-32)/1.8
    }
    
    init(celcius: Float) {
        self.temp_celcius = celcius
    }
    
    init(fahrenheit: Float) {
        self.temp_celcius = Self.from_fahrenheit(fahrenheit)
    }
    
}

struct Vector2 {
    public var x:Float = 0
    public var y:Float = 0
    
    init(_ x: Float, _ y: Float) {
        self.x = x
        self.y = y
    }
    
    static func + (left:Vector2, right:Vector2) -> Vector2 {
        return Vector2(left.x + right.x, left.y + right.y)
    }
    
    static func - (left: Vector2, right:Vector2) -> Vector2 {
        return Vector2(left.x - right.x, left.y - right.y)

    }
}

var triDemoA = Triangle(base:10, height:20)
var triDemoB = triDemoA

triDemoB.base = 80

print("triangle A has changed its base value from 10 to \(triDemoA.base)")

var greeting = "Hello, playground"

//: [Next](@next)
