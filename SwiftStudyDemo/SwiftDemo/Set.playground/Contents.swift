//: Playground - noun: a place where people can play

import UIKit
import Foundation

var letters = Set<Character>()
letters.insert("a")
letters
// remove all object
letters = []

// initialize a set with an array literal, as a shorthand way to write one or more values as a set collection.
var favoriteGenres: Set<String> = ["MJ", "BX", "AB", "He"]

// You alse can
var favoriteGenres2: Set = ["MJ", "BX", "AB", "He"]

favoriteGenres.isEmpty

favoriteGenres.remove("MJ")
favoriteGenres.remove("Hello")
favoriteGenres

for genres in favoriteGenres {
//    print(genres)
}

// Sorted
for genres in favoriteGenres.sorted() {
    print(genres)
}

var oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

// 并集
oddDigits.union(evenDigits).sorted()
// 交集
oddDigits.intersection(evenDigits).sorted()

oddDigits.subtract(singleDigitPrimeNumbers)


