//
//  shop_lib.swift
//  market-app
//
//  Created by Joshua Sulouff  on 8/25/25.
//

/*
 Assignment 1 — Mini Marketplace System
 Problem Statement
  
 You are tasked with designing a Mini Marketplace system in Swift. The system should allow users to browse products, add items to a cart, apply discounts, and compute totals.
  
 The design should be modular and demonstrate good use of Swift language features.
 
 Requirements
 Models
 Services
 Protocols
 Generics & Associated Type
 Closures
 Higher-Order Functions
 Error Handling
 
 
 Expected Features
 X    •    Add products to catalog.
 X    •    Search products by closure filter.
 X    •    Add/remove products to/from cart.
 X    •    Apply discount rules (flat and percent).
 X    •    Print cart summary (total, discount applied, grouped by category).
 X    •    Define a MarketError enum (productNotFound, invalidQty, outOfStock).
     •    Throw and handle errors in addToCart.
 X    •    Use map, filter, reduce, compactMap to:
 X    ◦    Extract product names.
 X    ◦    Filter products by category.
 X    ◦    Compute cart total.
     ◦    Remove invalid coupons (compactMap).
     •    Use closures for:
 X    ◦    Searching/filtering products (search(whereClause:)).
     ◦    Sorting products (inline comparator).
 X    ◦    Trailing closure syntax at least once.
 X    •    Create a generic Repository with an associatedtype Item.
 X    •    Implement a generic in-memory repository for products or cart items.
 X    •    Create protocols for IdentifiableEntity and Priceable.
 X    •    Demonstrate protocol inheritance (Discountable: Priceable).
 X    •    Show protocol composition in at least one function parameter.
 X    •    Add a default implementation via protocol extensions (POP style).
 X    •    Create a base class Service.
 X    •    Inherit InventoryService (manages products) and CartService (manages cart & totals).
 X    •    => Define a Product (struct) with id, name, category, price.
 X    •    Define a CartItem (struct) that holds a product and quantity.
 X    •    Use an enum with raw values for Category (e.g., electronics, grocery, apparel).
 X    •    Use an enum with associated values for PriceRule (flat(Double), percent(Double)).
 */

typealias Locale = [String:String]

protocol Repo {
    associatedtype StorageType
    func add(_ thing: StorageType)
    func remove(_ thing: StorageType)
}

class RepoGeneric<T> {
    var storage:[T] = []
}

let LOCALE_ENGLISH = [
    "cat_hardware" : "Hardware",
    "cat_tools" : "Tools",
    "cat_paint" : "Paint",
    "cat_electrical" : "Electrical",
    "cat_chem" : "Chemical",
    "cat_cleaning":"Cleaning Supplies",
    "cat_pest_control":"Pest Control",
    "cat_hand_soap":"Hand Soap",
    "cat_shampoo":"Shampoo & Conditioner",
    "cat_food":"Food",
    "cat_beverage":"Beverages",
    "cat_soda":"Soft Drinks",
    "cat_breakfast":"Breakfast",
    "cat_meat":"Meat",
    "cat_dairy":"Dairy",
    "cat_milk":"Milk",
    "cat_home":"Home & Garden",
    "cat_bath":"Bathroom",
]

extension Locale {
    func get(id:String) -> String {
        if let value = self[id] {
            return value
        }
        else {
            return id
        }
    }
}

protocol GetDisplay {
    associatedtype displayFields
    func getDisplay() -> displayFields
}

enum ShopError:Error {
    case productNotFound(ProductId)
    case noSuchProduct(String)
    case invalidQuantity(Int)
    case contextFailure
}

enum ProductCategory {
    case hardware, tools, paint, electrical
    case chemical, cleaning, pestControl, handSoap, shampoo
    case food, beverages, soda, breakfast, meat, dairy, milk
    case home, bathroom
    
    func getLocaleName() -> String {
        switch self {
        case .hardware: return "cat_hardware"
        case .tools: return "cat_tools"
        case .paint: return "cat_paint"
        case .electrical: return "cat_electrical"
        case .chemical: return "cat_chem"
        case .cleaning: return "cat_cleaning"
        case .pestControl: return "cat_pest_control"
        case .handSoap: return "cat_hand_soap"
        case .shampoo: return "cat_shampoo"
        case .food: return "cat_food"
        case .beverages: return "cat_beverages"
        case .soda: return "cat_soda"
        case .breakfast: return "cat_soft_drinks"
        case .meat: return "cat_meat"
        case .dairy: return "cat_dairy"
        case .milk: return "cat_milk"
        case .home: return "cat_home"
        case .bathroom: return "cat_bath"
        }
    
    }
    
    func getParentCategories() -> [ProductCategory] {
        switch self {
            case .tools, .paint, .electrical:
                return [.hardware]
        case .cleaning, .pestControl, .handSoap, .shampoo:
            return [.chemical]
        case .soda:
            return [.beverages]
        case .milk:
            return [.beverages, .dairy]
        case .breakfast, .meat:
            return [.food]
        case .bathroom:
            return [.home]
        default:
            return []
        }
    }
    
}

let PRICE_UNIT_PER_DOLLAR:Double = 1000
typealias MoneyUnit = Int
extension MoneyUnit {
    
    init(price real:Double) {
        self = Int(real * PRICE_UNIT_PER_DOLLAR)
    }
    
    func getReal() -> Double {
        return Double(self) / PRICE_UNIT_PER_DOLLAR
    }
    
}

protocol Priceable {
    func getPrice() -> MoneyUnit
}

protocol Discountable : Priceable {
    func priceWithDiscount(_ disc:Discount) -> MoneyUnit
}

extension Discountable {
    func priceWithDiscount(_ disc:Discount) -> MoneyUnit {
        return disc.rule.transformValue(self.getPrice())
    }
}

// function demonstrating protocol composition
typealias PriceModifiable = Priceable & Discountable
func halfOff(thing:any PriceModifiable) -> MoneyUnit {
    return thing.getPrice() / 2
}

print(halfOff(thing: Product(name: "Toilet Paper", category: .bathroom, price: 4.99)).asReal)

typealias ProductId = Int
struct Product {
    
    weak var ctx:AppContext?
    
    var productId:ProductId = 0
    
    var price:MoneyUnit // fixed point, in tenths of a cent
    var priceAsDouble:Double {
        return self.price.getReal()
    }
    
    var name: String
    var category:ProductCategory
    
    init(name: String, category: ProductCategory, price: Double) {
        self.productId = 0
        self.price = MoneyUnit(price:price)
        self.name = name
        self.category = category
    }
    
}

extension Product:Priceable, Discountable {
    func getPrice() -> MoneyUnit {
        return self.price
    }
}



class Service {
    
}

class InventorySvc: Service {
    var products:[Product]
    
    
    // Searches for all products containing the input
    func searchName(_ str:String) -> [String] {
        return products.filter() {
            prod in
            prod.name.contains(str)
        }
        .map() {
            product in
            product.name
        }
    }
    
    func listInCategory(_ category:ProductCategory) -> [String] {
        return products.filter() {
            product in
            product.category == category
        }
        .map() {
            product in
            product.name
        }
    }
    
    // Adds a product to the catalog
    func addProduct(_ product:Product) {
        var prodWithId = product
        prodWithId.productId = self.products.count
        products.append(prodWithId)
    }
    
    func addProducts(_ prods:[Product]) {
        for prod in prods {
            self.addProduct(prod)
        }
    }
    
    func getProduct(id:ProductId) -> Product? {
        return products[id]
    }
    
    init(products: [Product]) {
        self.products = []
        self.products.reserveCapacity(products.count)
        
        super.init()
        
        for prod in products {
            addProduct(prod)
        }
    }
    
    func genProdsList() -> String {
        var res = ""
        
        for product in products {
            res += "\(product.name)\n"
        }
        
        return res
    }
    
}

struct CartItem {
    weak var contextRef: AppContext?
    var productId:Int = 0
    var quantity:Int = 0
}

class CartSvc : Service {
    weak var ctx:AppContext? = nil
    var cart:[ProductId : Int] = [:]
    var discounts:[Discount] = []
    
    init(contextRef: AppContext?) {
        self.ctx = contextRef
        super.init()
    }
    
    func getCartItems() -> [(Product, Int)] {
        guard let context = self.ctx else {
            debugPrint("Cart Service is missing context!")
            return []
        }
        
        var baseArray:[(product:Product, quantity:Int)] = []
        
        for (k,v) in cart {
            if let prod = context.inventory.getProduct(id: k) {
                baseArray.append((prod, v))
            }
        }
        
        return baseArray
        
    }
    
    func addCartItemName(name:String, amount:Int) throws(ShopError) {
        
        guard let context = self.ctx else {
            debugPrint("Cart missing context!")
            return
        }
        
        for prod in context.inventory.products {
            if prod.name == name {
                self.addCartItem(item: prod.productId, amount: amount)
                return
            }
        }
        
        throw .noSuchProduct(name)
        
    }
    
    func addCartItem(item:ProductId, amount:Int) {
        
        let finalSum:Int
        if let currentQuantity = cart[item] {
            finalSum = currentQuantity + amount
        }
        else {
            finalSum = amount
        }
        
        if finalSum <= 0 && cart[item] != nil {
            cart.removeValue(forKey: item)
        }
        else {
            cart[item] = finalSum
        }
        
    }
    
    func genSummary() -> String {
        
        guard let context = self.ctx else {
            return "CANNOT GENERATE CART SUMMARY: NO CONTEXT POINTER"
        }
        
        var outp = "====== CART SUMMARY: ======\n"
        outp.reserveCapacity(256)
        
        var priceTotal:MoneyUnit = 0
        var savingTotal:MoneyUnit = 0
        
        for cartItem in self.getCartItems() {
            var pricePer = cartItem.0.price
            let itemName = cartItem.0.name
            let count = cartItem.1
            
            for coupon in self.discounts {
                if coupon.canApply(product: cartItem.0) {
                    let old = pricePer
                    pricePer = coupon.rule.transformValue(pricePer)
                    savingTotal += count * (old - pricePer)
                }
            }
            
            let itemTotal = pricePer * count
            
            outp += "\(itemName) x\(count) = \(itemTotal.asReal)\n"
            priceTotal += count * pricePer
        }
        
        outp += "TOTAL: \(priceTotal.asReal) (\(savingTotal.asReal) in savings!)"
        
        return outp
    }
    
}

typealias PercentageUnit = Int
extension PercentageUnit {
    static let UNITS_PER_WHOLE:Double = 10000.0
    var asReal:Double {
        return (Double(self) / Self.UNITS_PER_WHOLE)
    }
}

enum DiscountRule {
    case percent(PercentageUnit)
    case deduction(MoneyUnit)
}

extension DiscountRule {
    func transformValue(_ input:MoneyUnit) -> MoneyUnit {
        switch self {
        case .deduction(let amount):
            return MoneyUnit(input - amount)
        case .percent(let percent) :
            return MoneyUnit(input.asReal * percent.asReal)
        }
    }
}

struct Discount {
    var rule:DiscountRule
    var eligibleProducts:[ProductId]
    var eligibleCategories:[ProductCategory]
    
    init(rule: DiscountRule, eligibleProducts: [ProductId], eligibleCategories: [ProductCategory]) {
        self.rule = rule
        self.eligibleProducts = eligibleProducts
        self.eligibleCategories = eligibleCategories
    }
    
    func canApply(product:Product) -> Bool {
        
        let productId = product.productId
        let parentGroups = product.category.getParentCategories()
        
        for eligible in eligibleProducts {
            if eligible == productId {
                return true
            }
        }
        
        for eligibleCategory in eligibleCategories {
            if eligibleCategory == product.category {
                return true
            }
            else {
                for parentGroup in parentGroups {
                    if eligibleCategory == parentGroup {
                        return true
                    }
                }
            }
        }
        
        return false
        
    }
}

class AppContext {
    var inventory:InventorySvc
    var cart:CartSvc
    var locale:Locale
    
    
    
    init(inventory: [Product]) {
        self.inventory = InventorySvc(products:inventory)
        self.cart = CartSvc(contextRef:nil)
        self.locale = LOCALE_ENGLISH
        self.cart.ctx = self
    }
}

/*
 Product(name: "Toilet Paper", category: .bathroom, price: 4.99),
 Product(name: "Toothpaste", category: .bathroom, price: 7.89),
 Product(name: "Light switch panel", category: .hardware, price: 1.75),
 Product(name: "Bleach", category: .cleaning, price: 1.99),
 Product(name: "Apple", category: .food, price: 0.50),
 Product(name: "Pear", category: .food, price: 0.65),
 Product(name: "Bug spray", category: .pestControl, price: 7.56)
 */

func testSession() {
    let DEFAULT_INVENTORY: [Product] = [
        Product(name: "Toilet Paper", category: .bathroom, price: 4.99),
        Product(name: "Toothpaste", category: .bathroom, price: 7.89),
        Product(name: "Light switch panel", category: .hardware, price: 1.75),
        Product(name: "Bleach", category: .cleaning, price: 1.99),
        Product(name: "Apple", category: .food, price: 0.50),
        Product(name: "Pear", category: .food, price: 0.65),
        Product(name: "Bug spray", category: .pestControl, price: 7.56),
    ]
    var session = AppContext(inventory: DEFAULT_INVENTORY)
    print(session.cart.genSummary())
    do {
        try session.cart.addCartItemName(name: "Toilet Paper", amount: 12)
        print(session.cart.genSummary())
        try session.cart.addCartItemName(name: "Bleach", amount: 1)
        
        // remove from cart
        try session.cart.addCartItemName(name: "Toilet Paper", amount: -18)
        print(session.cart.genSummary())
        
        // Add a coupon
        session.cart.discounts.append(Discount(rule: .percent(40), eligibleProducts: [3], eligibleCategories: []))
        print(session.cart.genSummary())
        
        // Create new inventory items
        session.inventory.addProduct(Product(name: "Lemon", category: .food, price: 1.20))
        try session.cart.addCartItemName(name: "Lemon", amount: 4)
        print(session.cart.genSummary())
    }
    catch {
        switch error {
        case .noSuchProduct(let v):
            debugPrint("No such product \(v)")
        default:
            debugPrint("Other Error")
        }
    }
    // add items to cart
    
    
    // search for items
    print(session.inventory.searchName("o"))
    print(session.inventory.listInCategory(.bathroom))
    
}

testSession()
