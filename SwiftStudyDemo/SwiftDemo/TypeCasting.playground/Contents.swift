//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]


// Use the type check operator (is) to check whether an instance is of a certain subclass type. The type check operator returns true if the instance is of that subclass type and false if it is not.

library[0] is Movie
library[0] is Song

var hello = "Hello world"
var aFolat: Float = 1.2
library.first

/*
 Use the conditional form of the type cast operator (as?) when you are not sure if the downcast will succeed. This form of the operator will always return an optional value, and the value will be nil if the downcast was not possible. This enables you to check for a successful downcast.
 
 Use the forced form of the type cast operator (as!) only when you are sure that the downcast will always succeed. This form of the operator will trigger a runtime error if you try to downcast to an incorrect class type.
 */
for item in library {
    if let movie = item as? Movie {
        print(movie.name)
    }else if let song = item as? Song{
        print(song.name)
    }
}

/*
 Any can represent an instance of any type at all, including function types.
 AnyObject can represent an instance of any class type.
 */

var anyArray = [Any]()
anyArray.append(1)
anyArray.append("String")
anyArray.append(Song(name: "菊花台", artist: "周杰伦"))

for thing in anyArray {

}
