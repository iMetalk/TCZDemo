//: Playground - noun: a place where people can play

import UIKit
import Foundation

// The type of a Swift dictionary is written in full as Dictionary<Key, Value>, where Key is the type of value that can be used as a dictionary key, and Value is the type of value that the dictionary stores for those keys.

var numberOfIntegers = [Int: String]()

numberOfIntegers[15] = "sixteen"

// Clear
numberOfIntegers = [:]

var books: [String: String] = ["1": "Hello", "2": "world"]

// Update
books["1"] = "1Hello"

if let oldValue = books.updateValue("NewHello", forKey: "1"){
    print("oldValue: \(oldValue)")
}

// Remove
books["1"] = nil
books
if let oldValue = books.removeValue(forKey: "2"){
    print("oldValue: \(oldValue)")
}

books["1"] = "good"

for (airportCode, airportName) in books {
    print("\(airportCode): \(airportName)")
}

for key in books.keys {
    print(key)
}

for value in books.values {
    print(value)
}

let keys = [String](books.keys)
let values = [String](books.values)






