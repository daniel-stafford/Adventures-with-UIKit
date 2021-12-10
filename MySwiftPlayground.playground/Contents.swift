import Cocoa

//*** VARIABLES ***

var name = "Daniel"
name = "Bob"
name = "Frank"
print(name)

// let is equal to Javascript's const (whereas var = let)
let gender = "male"

var playerName = "Framk"
print(playerName)
playerName = "John"
print(playerName)
playerName = "Daniel"
print(playerName)


// *** STRINGS ***

let actor = "Denzel Washington"
let filename = "paris.jpg"
let result = "⭐️ You win! ⭐️"



//escape quotes inside quoes with backslash
let quote = "Then he tapped a sign saying \"Believe\" and walked away."

//multi-lines quite as such
let movie = """
A day in
the life of an
Apple engineer
"""
print(movie)
print(actor.count)

let nameLength = actor.count
print(nameLength)

print(result.uppercased())

//whether a string starts with some letters of our choosing:
print(movie.hasPrefix("A day"))

//checks whether a string ends with some text:
print(filename.hasSuffix(".jpg"))

// strings are case sensitive

// **** WHOLE NUMBERS ******

let score = 10
var reallyBig = 100000000

//swift ignores underscores
reallyBig = 100_000_000
reallyBig = 1_00__00___00____00

let lowerScore = score - 2
let higherScore = score + 10
let doubledScore = score * 2
let squaredScore = score * score
let halvedScore = score / 2
print(score)

var counter = 10
counter = counter + 5

counter += 5
print(score)

counter *= 2
print(score)
counter -= 10
print(score)
counter /= 2
print(score)

let number = 120
print(number.isMultiple(of: 3))
print(120.isMultiple(of: 3))

// *** DECIMAL NUMBERS ***


//classic problem of decimals stored as floating point numbers
// swift considers it a double (double precision floating-point number)
let decimal = 0.1 + 0.2
print(decimal) // 0.30000000000000004

// cannot mix ints and doubles
let a = 1
let b = 2.0
//let c = a + b
let c = a + Int(b)
let d = Double(a) + b

let double1 = 3.1
let double2 = 3131.3131
let double3 = 3.0
let int1 = 3

//cannot switch types
//var name = "Nicolas Cage"
//name = 57

var rating = 5.0
rating *= 2
print(rating)
