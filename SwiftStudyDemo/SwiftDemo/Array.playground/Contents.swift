//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var someInts = [Int]()
someInts.append(10)
someInts = []

var threeDoubles = Array(repeating: 1.0, count: 2)
var anotherThreeDoubles = Array(repeating: 2.0, count: 5)
var sixDoubles = threeDoubles + anotherThreeDoubles

var shopList: [String] = ["edge", "milk"]
shopList.count
shopList.isEmpty

shopList.append("water")
shopList += ["dadou", "hulu"]
shopList[0]
shopList[0] = "123"
shopList
shopList[0...3] = ["1", "2"]
shopList
shopList.removeLast()
shopList.remove(at: 0)
shopList

shopList.append("1")
for foodName in shopList {
    print(foodName)
}

for (index, value) in shopList.enumerated() {
    print("\(index)" + "\(value)")
}

var twoArray = [Array<Int>]()
twoArray.append([1])


