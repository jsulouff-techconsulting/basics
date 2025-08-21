//: [Previous](@previous)

/*
 
 Assignment 5
 In Swift playgorund have multiple examples to show usage of below:
 X 1.Properties : Stored,  Computed , Static

 X 2.extension usage

 X 3.Protocols
   X 1.    Define a protocol Playable with a method play(). Make Music and Video structs conform to it.
   X 2.    Create a protocol Shape with an area() method. Implement Circle and Rectangle.
   X 3.    Make a protocol Cacheable with methods save(key:value:) and load(key:). Implement it with a Dictionary.
   X 4.    Use protocol extensions to give Greetable a default sayHi() method.
 
 */

import Foundation

protocol Greetable {
    func sayHi()
}

extension Greetable {
    func sayHi() {
        print("hi!")
    }
}
protocol Playable {
    func play()
}

struct Music {
    var runtime:Double = 1.0
    var bitrate:Double = 1000
}

extension Music: Playable {
    func play() {
        print("Playing a song with a runtime of \(self.runtime) at a bitrate of \(self.bitrate)")
    }
}

struct Movie {
    var runtime:Double = 20
    var colorDepth:Int = 64
}

extension Movie: Playable {
    func play() {
        print("Playing a movie with a runtime of \(self.runtime) and a color depth of \(self.colorDepth)")
    }
}

protocol Shape {
    func area() -> Float
    func perimeter() -> Float
}

protocol SideCount {
    func get_side_count() -> Int
}

struct Triangle {
    var base = 1.0
    var height = 2.0
    static let number_of_sides = 3
}

extension Triangle: SideCount {
    func get_side_count() -> Int {
        return Self.number_of_sides
    }
}

extension Triangle: Shape {
    func area() -> Float {
        return Float(self.base * self.height * 0.5)
    }
    func perimeter() -> Float {
        let legs_len = sqrt(pow(base * 0.5, 2) + pow(height, 2)) // dont quote me on this
        return Float(base + legs_len)
    }
}

struct Rectangle {
    var length = 1.0
    var width = 2.0
    
    var lw_ratio:Double {
        return self.length / self.width
    }
    
    
    
}

extension Rectangle : Shape {
    func area() -> Float {
        return Float(self.length * self.width)
    }
    func perimeter() -> Float {
        return Float(length * 2 + width * 2)
    }
}

extension Rectangle : SideCount {
    func get_side_count() -> Int {
        return 4
    }
}

struct Circle {
    var radius = 1.0
}

extension Circle: Shape {
    func area() -> Float {
        return Float(pow(self.radius , 2.0)) * Float.pi
    }
    func perimeter() -> Float {
        return Float(2.0 * Double.pi * self.radius)
    }
}

protocol Cacheable {
    mutating func save(key:String, value:String)
    func load(key:String) -> String?
}

extension [String:String]: Cacheable {
    mutating func save(key: String, value: String) {
        self[key] = value
    }
    func load(key: String) -> String? {
        return self[key]
    }
}

