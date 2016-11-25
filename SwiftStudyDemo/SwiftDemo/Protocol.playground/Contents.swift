//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 Property requirements are always declared as variable properties, prefixed with the var keyword. Gettable and settable properties are indicated by writing { get set } after their type declaration, and gettable properties are indicated by writing { get }.
 */
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedSettable: Int { get }
    
    static var someTypeProperty: Int { get set }
    
    // class or static keyword when implemented by a class:
    static func someTypeMethod()
    
    // It is sometimes necessary for a method to modify (or mutate) the instance it belongs to. For instance methods on value types (that is, structures and enumerations) you place the mutating keyword before a method’s func keyword to indicate that the method is allowed to modify the instance it belongs to and any properties of that instance.
    mutating func chageInstanceValue()
    
    // Protocols can require specific initializers to be implemented by conforming types.
    init(someParameter: Int)
    
    
}


protocol FullNamed {
    var fullName: String { get set}
}

struct Person: FullNamed {
    var fullName: String
}
let join = Person(fullName: "Join")


protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    func random() -> Double {
        return 1.0
    }
}

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()


protocol AInitable {
    init(goodsCount: Int)
}

class Good: AInitable {
    required init(goodsCount: Int) {
        
    }
}

// Protocols as Types
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

// Delegation
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    
    func play() {
        square = 0
        
        delegate?.gameDidStart(self)
        
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


// Adding Protocol Conformance with an Extension
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

// Collections of Protocol Types
// A protocol can be used as the type to be stored in a collection such as an array or a dictionary, as mentioned in Protocols as Types.
let things: [TextRepresentable] = []


// Protocol Inheritance
protocol InheritingProtocol: TextRepresentable {
    
}


// Class-Only Protocols
// You can limit protocol adoption to class types (and not structures or enumerations) by adding the class keyword to a protocol’s inheritance list. The class keyword must always appear first in a protocol’s inheritance list, before any inherited protocols:
protocol SomeClassOnlyProtocol: class, TextRepresentable {
    
}

// Protocol Composition
// It can be useful to require a type to conform to multiple protocols at once separating them by ampersands (&).
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct PersonMan: Named, Aged {
    var name: String
    var age: Int
}

class PersonManName {
    class func wishHappyBirthday(to celebrator: Named & Aged) {
        print("\(celebrator.age)" + celebrator.name)
    }
}


let aperson = PersonMan(name: "Lefe", age: 20)
PersonManName.wishHappyBirthday(to: aperson)

// Checking for Protocol Conformance
/*
 The is operator returns true if an instance conforms to a protocol and returns false if it does not.
 The as? version of the downcast operator returns an optional value of the protocol’s type, and this value is nil if the instance does not conform to that protocol.
 The as! version of the downcast operator forces the downcast to the protocol type and triggers a runtime error if the downcast does not succeed.
 */


// Optional Protocol Requirements
// @objc protocols can be adopted only by classes that inherit from Objective-C classes or other @objc classes. They can’t be adopted by structures or enumerations.

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
}

// Protocol Extensions
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}


// Providing Default Implementations
protocol DefaultImplementations {
    func defaultName() -> String
}

extension DefaultImplementations {
    func defaultName() -> String {
        return "Hello"
    }
}

class Hello: DefaultImplementations {
    
}

// Adding Constraints to Protocol Extensions
extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

