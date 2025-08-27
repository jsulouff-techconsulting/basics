/*
 Assignment 9 — Swift Playground

 Dependency Injection
   X  1.    Create a DataService protocol.
   X  2.    Implement NetworkService and MockService some dummy function
   X  3.    Inject service into DataManager via initializer.
   X  4.    Show switching between live and mock.

 Dependency Inversion
    X 1.Constructor injection
    X 2.Property injection,
     3.Method Injection usage
 Copy-on-Write (CoW)
     1.    Create a = [1,2,3], b = a.
     2.    Print buffer addresses of both.
     3.    Mutate b and print addresses again.
     4.    Show that class elements inside arrays still share reference.

 ARC (Strong / Weak / Unowned)
     1.    Create a Manager class with deinit.
     2.    Show deallocation with strong reference.
     3.    Demonstrate weak reference (becomes nil).
     4.    Demonstrate unowned reference (must outlive owner).

 Retain Cycles
     1.    Create class A and class B holding strong refs to each other → no deinit.
     2.    Fix by making one side weak.
 <@1405168079570206853> <@1405553539077378060> <@1402361311383392439> <@1392205516729614400> Also complete pending yesterdays assignment in playgorund
 */

import Foundation

protocol DataService {
    func getData() -> String
}

class NetworkService {
    
}

extension NetworkService : DataService {
    func getData() -> String {
        return "Data from network"
    }
}

class MockService {
    
}

extension MockService: DataService {
    func getData() -> String {
        return "Data from mock service"
    }
}

class DataManager {
    var dataSourceService: any DataService
    var dataTransformMethod: (String) -> String = {str in str}
    var dataSuffix = ""
    
    init(dataSourceService: any DataService) {
        self.dataSourceService = dataSourceService
    }
    
    func fetch() -> String {
        return dataSourceService.getData() + self.dataSuffix
    }
    
    func setDataSuffix(suffix:String) {
        self.dataSuffix = suffix
    }
    
}

var prodDataManager = DataManager(dataSourceService: NetworkService())
let mockDataManager = DataManager(dataSourceService: MockService())

print("data from network: \(prodDataManager.fetch())\ndata from mock: \(mockDataManager.fetch())")

prodDataManager.dataTransformMethod = {str in str.uppercased()}
prodDataManager.dataSuffix = "_NON_TRANSFORM"

print("Prod data manager after altering dependencies:\(prodDataManager.fetch())")

class Manager {
    init() {
        print("Manager allocated.")
    }
    deinit {
        print("Manager freed.")
    }
}

do {
    
    func printAddress(v:Any) {
        withUnsafePointer(to:v) {
            print("\($0)")
        }
    }
    
    let a = [1,2,3]
    var b = a
    
    print("B and A:")
    printAddress(v: a) ; printAddress(v: b)
    
    b[0] = 12
    
    print("B and A (after mutating b):")
    printAddress(v: a) ; printAddress(v: b)
    
    let sampleFirst = Manager()
    let sample = [sampleFirst]
    
    print("Two references to a class instance, one is in an array")
    printAddress(v: sampleFirst) ; printAddress(v: sample[0])
    
}



var man:Manager? = Manager()
weak var manRefWeak = man
unowned var manRefUnowned = man


man = nil
print("Weak manager reference: \(String(describing:manRefWeak))")

/*
do {
    try ("Unowned: \(manRefUnowned)")
}
catch {
    print("crashed from deref unowned")
}
*/

class B {
    weak var aRef:A?
    init() {
        
    }
}

class A {
    var bRef:B?
}

var b = B()
var a = A()
a.bRef = b
b.aRef = a
