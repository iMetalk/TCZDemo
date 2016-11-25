//: Playground - noun: a place where people can play

import UIKit

/*
 Computed properties are provided by classes, structures, and enumerations. Stored properties are provided only by classes and structures.
 */
struct FirstLengthRange {
    var firstValue: Int
    var lenght: Int
}



// Lazy Stored Properties
class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

var dataManager = DataManager()
dataManager.data.append("Hello")
dataManager.importer.fileName


var totalSteps: Int = 0 {
willSet(newTotalSteps) {
    print("About to set totalSteps to \(newTotalSteps)")
}
didSet {
    if totalSteps > oldValue  {
        print("Added \(totalSteps - oldValue) steps")
    }
}
}





