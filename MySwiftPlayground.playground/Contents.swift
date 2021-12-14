import Cocoa
import Darwin

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


// *** BOOLEANS ***

let goodDogs = true
let gameOver = false

//! same as JS
var isAuthenticated = false
isAuthenticated = !isAuthenticated
print(isAuthenticated)
isAuthenticated = !isAuthenticated
print(isAuthenticated)


//toggle()
var gameOver2 = false
print(gameOver)

gameOver2.toggle()
print(gameOver)

//Use \(someVariable) to activate string interpolation.


/*Creates a constant holding any temperature in Celsius.
 Converts it to Fahrenheit by multiplying by 9, dividing by 5, then adding 32.
 Prints the result for the user, showing both the Celsius and Fahrenheit values.*/


let cel = 5
let far = (cel * 9) / 5 + 32
print("\(cel)°c is \(far)°f")

// *** Arrays ***
var beatles = ["John", "Paul", "George", "Ringo"]
let numbers = [4, 8, 15, 16, 23, 42]
var temperatures = [25.3, 28.2, 26.4]

print(beatles[0])
print(numbers[1])
print(temperatures[2])

beatles.append("Adrian")

beatles.append("Allen")
beatles.append("Adrian")
beatles.append("Novall")
beatles.append("Vivian")

//must be same types
//temperatures.append("Chris")

let firstBeatle = beatles[0]
let firstNumber = numbers[0]
//let notAllowed = firstBeatle + firstNumber

//specific array
var scores = Array<Int>()
scores.append(100)
scores.append(80)
scores.append(85)
print(scores[1])

var albums = Array<String>()
albums.append("Folklore")
albums.append("Fearless")
albums.append("Red")

//shorthand
var albums2 = [String]()
albums.append("Folklore")
albums.append("Fearless")
albums.append("Red")

//swift can implicitly figure out time if you assign at leaset one value
var albums3 = ["Folklore"]
albums.append("Fearless")
albums.append("Red")

print(albums.count)

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)

characters.remove(at: 2)
print(characters.count)

characters.removeAll()
print(characters.count)

let bondMovies = ["Casino Royale", "Spectre", "No Time To Die"]
print(bondMovies.contains("Frozen"))

let cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted())


// So, when you print out reversedPresidents, don’t be surprised to see it’s not just a simple array any more!
let presidents = ["Bush", "Obama", "Trump", "Biden"]
let reversedPresidents = presidents.reversed()
print(reversedPresidents)


// ^^ TUPLES
var singer = (first: "Taylor", last: "Swift")


//*** DICTIONARIES ***
// order, duplicates
// Arrays are a great choice when items should be stored in the order you add them, or when you might have duplicate items in there, but very often accessingdataby its position in the array can be annoying or even dangerous.
// Dictionaries don’t store items according to their position like arrays do, but instead let us decide where items should be stored.


//key value pairs
let employee2 = [
    "name": "Taylor Swift",
    "job": "Singer",
    "location": "Nashville"
]

//issue of optionals - whether the data is not there or not, you sure you want to print it?
print(employee2["name"])
print(employee2["job"])
print(employee2["location"])

//in case of a key does not exsist, add optional
print(employee2["name", default: "Unknown"])
print(employee2["job", default: "Unknown"])
print(employee2["location", default: "Unknown"])

//string: string
let hasGraduated = [
    "Eric": false,
    "Maeve": true,
    "Otis": false,
]

// int: string
let olympics = [
    2012: "London",
    2016: "Rio de Janeiro",
    2021: "Tokyo"
]

print(olympics[2012, default: "Unknown"])

// string : int explicit typing
var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["LeBron James"] = 206


var archEnemies = [String: String]()
archEnemies["Batman"] = "The Joker"
archEnemies["Superman"] = "Lex Luthor"
// duplicate key will overwrite
archEnemies["Batman"] = "Penguin"
print(archEnemies)


// *** SETS ***

//no order, no duplicates, fast to find element (as opposed to arrays)

let people = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])
print(people)

var people2 = Set<String>()
people2.insert("Denzel Washington")
people2.insert("Tom Cruise")
people2.insert("Nicolas Cage")
people2.insert("Samuel L Jackson")


// *** ENUMS ***
//super fast to work with

enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

enum status {
    case started, done, deleted
}

//
var day = Weekday.monday
day = Weekday.tuesday
day = Weekday.friday
day = .friday

// *** TYPE ANNOTATIONS ***

//explciit
let surname: String = "Lasso"
var score3: Int = 0

//String, Int, Double, Bool, [String], [String: String]. Set<String>

var foods: [String] = [String]()
// is euqal to
var foods2: [String] = []
//is requal to
var food3 = [String]()

enum UIStyle {
    case light, dark, system
}

var style = UIStyle.light
style = .dark

//USE TYPE INFERENCE WHEN POSSIBLE, often you need to explicit with constant that doesn't have a value yet.

let username: String
username = "@blahblah"
//username = "thiswontwork"
print(username)

// CHECKPOINT 2

// create an array of strings, then write some code that prints the number of items in the array and also the number of unique items in the array.

let myStringArr = ["Apple", "Peach", "Grape", "Apple"]
let myStringSet = Set(myStringArr)
let numItems = myStringArr.count
let numUniq = myStringSet.count
print("The number of items is \(numItems) while the number of unique items is \(numUniq)")

//*** IF STATEMENTS ****

//if someCondition {
//    print("Do something")
//}

let score4 = 85

if score4 > 80 {
    print("Great job!")
}

let speed = 88
let percentage = 85
let age = 18

if speed >= 88 {
    print("Where we're going we don't need roads.")
}

if percentage < 85 {
    print("Sorry, you failed the test.")
}

if age >= 18 {
    print("You're eligible to vote")
}


let ourName = "Dave Lister"
let friendName = "Arnold Rimmer"

//alphabetical
if ourName < friendName {
    print("It's \(ourName) vs \(friendName)")
}

if ourName > friendName {
    print("It's \(friendName) vs \(ourName)")
}


// Make an array of 3 numbers
var numbers2 = [1, 2, 3]

// Add a 4th
numbers2.append(4)

// If we have over 3 items
if numbers2.count > 3 {
    // Remove the oldest number
    numbers2.remove(at: 0)
}

// Display the result
print(numbers2)

let country = "Canada"

if country == "Australia" {
    print("G'day!")
}

let name4 = "Taylor Swift"

if name4 != "Anonymous" {
    print("Welcome, \(name)")
}

var userName = "taylorswift13"

// If `username` contains an empty string
if userName == "" {
    // Make it equal to "Anonymous"
    userName = "Anonymous"
}

// Now print a welcome message
print("Welcome, \(userName)!")

if userName.isEmpty == true {
    userName = "Anonymous"
}

//is equal to
if userName.isEmpty {
    userName = "Anonymous"
}

print(userName)

// *** MULTIPLE CONDITIONS WITH IF ***
let age4 = 16

if age4 >= 18 {
    print("You can vote in the next election.")
} else {
    print("Sorry, you're too young to vote.")
}

var temp = 12

if temp > 20 && temp < 30 {
    print("It's a nice day.")
}

let userAge = 14
let hasParentalConsent = true

if userAge >= 18 || hasParentalConsent {
    print("You can buy the game")
}

enum TransportOption {
    case airplane, helicopter, bicycle, car, scooter
}

let transport = TransportOption.airplane

if transport == .airplane || transport == .helicopter {
    print("Let's fly!")
} else if transport == .bicycle {
    print("I hope there's a bike path…")
} else if transport == .car {
    print("Time to get stuck in traffic.")
} else {
    print("I'm going to hire a scooter now!")
}

//*** SWITCH STATEMENTS ***

enum Weather {
    case sun, rain, wind, snow, unknown
}

let forecast = Weather.sun

// must be exhaustive and will complain about repeats
// will stop switching until passes (unlike C)
switch forecast {
case .sun:
    print("It should be a nice day.")
case .rain:
    print("Pack an umbrella.")
case .wind:
    print("Wear something warm")
case .snow:
    print("School is cancelled.")
case .unknown:
    print("Our forecast generator is broken!")
}

let place = "Metropolis"

switch place {
case "Gotham":
    print("You're Batman!")
case "Mega-City One":
    print("You're Judge Dredd!")
case "Wakanda":
    print("You're Black Panther!")
//f nothing matches, use matches, do not use with case
default:
    print("Who are you?")
}

let xmasday = 5
print("My true love gave to me…")

switch xmasday {
case 5:
    print("5 golden rings") // this will only print 5 golden rings
case 4:
    print("4 calling birds")
case 3:
    print("3 French hens")
case 2:
    print("2 turtle doves")
default:
    print("A partridge in a pear tree")
}


//fallthrough

let xmasday2 = 4
print("My true love gave to me…")

switch xmasday2 {
case 5:
    print("5 golden rings")
    fallthrough
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 French hens")
    fallthrough
case 2:
    print("2 turtle doves")
    fallthrough
default:
    print("A partridge in a pear tree")
}

//*** TERNARY CONDITIONAL OPERATOR
//WTF
//WHAT TRUE FALSE
//useful for performing certain logic inside function (like print) in SwiftUI

let age3 = 18
let canVote = age3 >= 18 ? "Yes" : "No"


let names = ["Jayne", "Kaylee", "Mal"]
let crewCount = names.isEmpty ? "No one" : "\(names.count) people"
print(crewCount)

enum Theme {
    case light, dark
}

let theme = Theme.dark

let background = theme == .dark ? "black" : "white"
print(background)

//*** FOR LOOP ***

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for os in platforms {
    print("Swift works great on \(os).")
}

for name in platforms {
    print("Swift works great on \(name).")
}

for rubberChicken in platforms {
    print("Swift works great on \(rubberChicken).")
}

for i in 1...12 { //llop veriable i
    print("5 x \(i) is \(5 * i)") //loop body
} //loop iteration

//cool autocomplete
//for platform in platforms {
//    <#body#>
//}

for i in 1...12 {
    print("The \(i) times table:")

    for j in 1...12 {
        print("  \(j) x \(i) is \(j * i)")
    }

    print() //empty line
}

for i in 1...5 {
    print("Counting from 1 through 5: \(i)") // 1 2 3 4 5
}

print()

// counting up to, useful for arrays
for i in 1..<5 {
    print("Counting 1 up to 5: \(i)") // 1 2 3 4
}

//when you don't need a loop variable
var lyric = "Haters gonna"

for _ in 1...5 {
    lyric += " hate"
}

print(lyric)

//*** WHILE LOOP ***

//useful when you do't know how many times the loop will iterate

var countdown = 10

while countdown > 0 {
    print("\(countdown)…")
    countdown -= 1
}

print("Blast off!")

let id = Int.random(in: 1...1000)
let amount = Double.random(in: 0...1)

// create an integer to store our roll
var roll = 0

// carry on looping until we reach 20
while roll != 20 {
    // roll a new dice and print what it was
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}

// if we're here it means the loop ended – we got a 20!
print("Critical hit!")

//You’ll find yourself using both for and while loops in your own code: for loops are more common when you have a finite amount of data to go through, such as a range or an array, but while loops are really helpful when you need a custom condition.


//*** SKIP LOOP ITEMS WITH BREAK AND CONITNUE ***


let filenames = ["me.jpg", "work.txt", "sophie.jpg", "logo.psd"]

for filename in filenames {
    if filename.hasSuffix(".jpg") == false {
        continue
    }

    print("Found picture: \(filename)")
}

let number1 = 4
let number2 = 14
var multiples = [Int]()

for i in 1...100_000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)

        if multiples.count == 10 {
            break
        }
    }
}

print(multiples)


//*** CHECKPOINT 3 ****

//Your goal is to loop from 1 through 100, and for each number:
//If it’s a multiple of 3, print “Fizz”
//If it’s a multiple of 5, print “Buzz”
//If it’s a multiple of 3 and 5, print “FizzBuzz”
//Otherwise, just print the number.

for i in 1...100 {
    if i.isMultiple(of: 3) && i.isMultiple(of: 5) {
        print("FizzBuzz")
    }
    else if i.isMultiple(of: 3){
        print("Fizz")
    } else if i.isMultiple(of: 5) {
        print("Buzz")
    }
        else {
            print(i)
        }
    }

//*** FUNCTIONS ***

func showWelcome() {
    print("Welcome to my app!")
    print("By default This prints out a conversion")
    print("chart from centimeters to inches, but you")
    print("can also set a custom range if you want.")
}

showWelcome()

let number5 = 139

if number5.isMultiple(of: 2) {
    print("Even")
} else {
    print("Odd")
}

let roll2 = Int.random(in: 1...20)


//func printTimesTables(number: Int) {
//    for i in 1...12 {
//        print("\(i) x \(number) is \(i * number)")
//    }
//}
//
//printTimesTables(number: 5)

func printTimesTables(number: Int, end: Int) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 20, end: 5)

//must add argument labels (parameters)
//printTimesTables(5, 20)

//*** RETURN FUNCTINONS ***

func rollDice() -> Int {
    Int.random(in: 1...6) //implicit one-line return
}

let result2 = rollDice()
print(result2)

//func areLettersIdentical(string1: String, string2: String) -> Bool {
//    let first = string1.sorted()
//    let second = string2.sorted()
//    return first == second
//}
//
//
//func areLettersIdentical(string1: String, string2: String) -> Bool {
//    return string1.sorted() == string2.sorted()
//}

//when a function has only one line of code, we can remove the return keyword entirely, like this:
func areLettersIdentical(string1: String, string2: String) -> Bool {
    string1.sorted() == string2.sorted()
}

func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

let h = pythagoras(a: 3, b: 4)
print(h)

//*** How to return multiple values from functions using tuples ***

func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let user = getUser()
print("Name: \(user.firstName) \(user.lastName)")

//shorthand
func getUser2() -> (firstName: String, lastName: String) {
    ("Taylor", "Swift")
}

let user2 = getUser()
print("Name: \(user.0) \(user.1)")

func getUser3() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let user3 = getUser3()
let firstName = user3.firstName
let lastName = user3.lastName

print("Name: \(firstName) \(lastName)")

//destructure
let (firstName2, lastName2) = getUser3()
print("Name: \(firstName2) \(lastName2)")

//don't need all valeus from tuple
let (firstName4, _) = getUser3()
print("Name: \(firstName4)")


//*** How to customize parameter labels ***

//This method of naming parameters for external use is so important to Swift that it actually uses the names when it comes to figuring out whichmethodto call. This is quite unlike many other languages, but this is perfect valid in Swift:  SUPER WEIRD! 😊

func hireEmployee(name: String) { }
func hireEmployee(title: String) { }
func hireEmployee(location: String) { }

let lyric2 = "I see a red door and I want it painted black"
print(lyric2.hasPrefix("I see"))

//When we call hasPrefix() we pass in the prefix to check for directly – we don’t say hasPrefix(string:) or, worse, hasPrefix(prefix:). How come?

//func isUppercase(string: String) -> Bool {
//    string == string.uppercased()
//}
//
//let string = "HELLO, WORLD"
//let result = isUppercase(string: string)

//If we add an 🔥underscore🔥 before the parameter name, we can remove the external parameter label like so:
func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let result3 = isUppercase(string)
print(result3)

func printTimesTables(number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5)

//reads better with for but for is a resserved word

//func printTimesTables(for: Int) {
//    for i in 1...12 {
//        print("\(i) x \(for) is \(i * for)")
//    }
//}
//
//printTimesTables(for: 5)

//use for as external paramter name, number is internal parameter

func printTimesTables(for number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5)

//There are three things in there you need to look at closely:
//
//We write for number: Int: the external name is for, the internal name is number, and it’s of type Int.
//When we call the function we use the external name for the parameter: printTimesTables(for: 5).
//Inside the function we use the internal name for the parameter: print("\(i) x \(number) is \(i * number)").

// *** How to provide default values for parameters ///

func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 20)
printTimesTables(for: 8)

var characters1 = ["Lana", "Pam", "Ray", "Sterling"]
print(characters1.count)
characters1.removeAll()
print(characters1.count)

characters.removeAll(keepingCapacity: true)
//This is accomplished using a default parameter value: keepingCapacity is a Boolean with the default value of false so that it does the sensible thing by default, while also leaving open the option of us passing in true for times we want to keep the array’s existing capacity.V

// ***  How to handle errors in functions ***

enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }

    if password == "12345" {
        throw PasswordError.obvious
    }

    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

//Let’s break that down…
//
//If a function is able to throw errors without handling them itself, you must mark the function as throws before the return type.
//We don’t specify exactly what kind of error is thrown by the function, just that it can throw errors.
//Being marked with throws does not mean the function must throw errors, only that it might.
//When it comes time to throw an error, we write throw followed by one of our PasswordError cases. This immediately exits the function, meaning that it won’t return a string.
//If no errors are thrown, the function must behave like normal – it needs to return a string.


//do {
//    try someRiskyWork()
//} catch {
//    print("Handle errors here")
//}

let blah = "12345"

do {
    let result = try checkPassword(blah)
    print("Password rating: \(result)")
} catch {
    print("There was an error.")
}


let meow = "12345"

do {
    let result = try checkPassword(meow)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error.\(error.localizedDescription)")
}

//Tip: Most errors thrown by Apple provide a meaningful message that you can present to your user if needed. Swift makes this available using an error value that’s automatically provided inside your catch block, and it’s common to read error.localizedDescription to see exactly what happened.

//Functions can throw errors: you create an enum defining the errors you want to happen, throw those errors inside the function as needed, then use do, try, and catch to handle them at the call site.

//** Checkpoint 4 ***


//The challenge is this: write a function that accepts an integer from 1 through 10,000, and returns the integer square root of that number. That sounds easy, but there are some catches:

//You can’t use Swift’s built-in sqrt() function or similar – you need to find the square root yourself.
//If the number is less than 1 or greater than 10,000 you should throw an “out of bounds” error.
//You should only consider integer square roots – don’t worry about the square root of 3 being 1.732, for example.
//If you can’t find the square root, throw a “no root” error.
//As a reminder, if you have number X, the square root of X will be another number that, when multiplied by itself, gives X. So, the square root of 9 is 3, because 3x3 is 9, and the square root of 25 is 5, because 5x5 is 25.

enum  getSquareError: Error {
    case outOfBounds, noRoot
}


func getSquare(num: Int) throws -> Int {
    if num < 1 || num > 10_000 {
        throw getSquareError.outOfBounds
    }
    let dbl = pow(Double(num), 1/2)
    if floor(dbl) != dbl {
        throw getSquareError.noRoot
    }
    return Int(dbl)
}


let myInt = 15

do {
    let result = try getSquare(num: myInt)
    print("The square of \(myInt) is \(result)")
} catch getSquareError.outOfBounds {
    print("Your number should be between 1 and 10,000")
} catch getSquareError.noRoot {
    print("There is no integer root for \(myInt)")
}

/// * How to create and use closures ///

func greetUser() {
    print("Hi there!")
}

greetUser()

var greetCopy = greetUser
greetCopy()

// Important: When you’re copying a function, you don’t write the parentheses after it – it’s var greetCopy = greetUser and not var greetCopy = greetUser(). If you put the parentheses there you are calling the function and assigning its return value back to something else.

let sayHello = {
    print("Hi there!")
}

sayHello()
//Swift gives this the grandiose name closure expression, which is a fancy way of saying we just created a closure – a chunk of code we can pass around and call whenever we want. This one doesn’t have a name, but otherwise it’s effectively a function that takes no parameters and doesn’t return a value.

//If you want the closure to accept parameters, they need to be written in a special way.
let sayHello2 = { (name: String) -> String in
    "Hi \(name)!"
}
//I added an extra keyword there – did you spot it? It’s the in keyword, and it comes directly after the parameters and return type of the closure. A

var greetCopy3: () -> Void = greetUser
//The empty parentheses marks a function that takes no parameters.
//The arrow means just what it means when creating a function: we’re about to declare the return type for the function.
//Void means “nothing” – this function returns nothing. Sometimes you might see this written as (), but we usually avoid that because it can be confused with the empty parameter list.

func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

//named parameters get lost when using closures (reference to a function)
//named parametse are only used when calling a function directly
let data: (Int) -> String = getUserData
let user4 = data(1989)
print(user4)


let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)


func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}

//sorted should accepted two strings and return a bool, so we can customize it
let captainFirstTeam = team.sorted(by: captainFirstSorted)
print(captainFirstTeam)

//writing a closure directly rather than reference
let captainFirstTeamClosure = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})

//We’re calling the sorted() function as before.
//Rather than passing in a function, we’re passing a closure – everything from the opening brace after by: down to the closing brace on the last line is part of the closure.
//Directly inside the closure we list the two parameters sorted() will pass us, which are two strings. We also say that our closure will return a Boolean, then mark the start of the closure’s code by using in.
//Everything else is just normal function code.

// *** How to use trailing closures and shorthand syntax ***

//trailing closure syntax
let captainFirstTeam4 = team.sorted { name1, name2 in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}

//shorthand syntax
let captainFirstTeam5 = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }

    return $0 < $1
}

//if just to just get a reverse sort, can make it one line
let reverseTeam = team.sorted { $0 > $1 }

//use shorthand UNLESS -
//1. The closure’s code is long.
//2. $0 and friends are used more than once each.
//3. You get three or more parameters (e.g. $2, $3, etc).
//

let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)

let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)

//going to be using closures a lot with SwiftUI:

//When you create a list of data on the screen, SwiftUI will ask you to provide a function that accepts one item from the list and converts it something it can display on-screen.
//When you create a button, SwiftUI will ask you to provide one function to execute when the button is pressed, and another to generate the contents of the button – a picture, or some text, and so on.
//Even just putting stacking pieces of text vertically is done using a closure.

//*** How to accept functions as parameters ***

func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()
    //dont need to use iterator variable so _ rather than i and from 0 until just before the size argument
    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }

    return numbers
}

//The function is called makeArray(). It takes two parameters, one of which is the number of integers we want, and also returns an array of integers.
//The second parameter is a function. This accepts no parameters itself, but will return one integer every time it’s called.
//Inside makeArray() we create a new empty array of integers, then loop as many times as requested.
//Each time the loop goes around we call the generator function that was passed in as a parameter. This will return one new integer, so we put that into the numbers array.
//Finally the finished array is returned.

let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}

print(rolls)

func generateNumber() -> Int {
    Int.random(in: 1...20)
}

let newRolls = makeArray(size: 50, using: generateNumber)
print(newRolls)

//function that accepts mutiple funcion parameters
func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}

//first parameter is unamed, while rest are named with braces
doImportantWork {
    print("This is the first work")
} second: {
    print("This is the second work")
} third: {
    print("This is the third work")
}

// *** Checkpoint 5 ***

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

//Filter out any numbers that are even
//Sort the array in ascending order
//Map them to strings in the format “7 is a lucky number”
//Print the resulting array, one item per line
//So, your output should be as follows:
//
//7 is a lucky number
//15 is a lucky number
//21 is a lucky number
//31 is a lucky number
//33 is a lucky number
//49 is a lucky number

let getLucky: ([Int]) -> Void = { arr in
    arr.filter { $0 % 2 != 0 }
    .sorted()
    .forEach { print("\($0) is a lucky number \n") }
}

getLucky(luckyNumbers)


// *** How to create your own structs ***

//similar to classes
//use capital letters for structures
struct Album {
    //properities
    let title: String
    let artist: String
    let year: Int
    //methods
    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}

//instance = intializer, similar to a function call (creates init function background, Album.init() -> {}
let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title)
print(wings.artist)

red.printSummary()
wings.printSummary()

struct Employee {
    let name: String
    var vacationRemaining: Int
    //when wanting to change data (write) add the word mutating
    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

//must use var instead of let when calling a mutating function inside a structure, cannot mutate a constant let, only variable
var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
archer.takeVacation(days: 5)
print(archer.vacationRemaining)



var archer1 = Employee(name: "Sterling Archer", vacationRemaining: 14)
var archer2 = Employee.init(name: "Sterling Archer", vacationRemaining: 14)

struct Employee2 {
    let name: String
    // you can override this as it you are using var, otherwise is a default value, let would prevent override
    var vacationRemaining = 14

    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

let kane = Employee2(name: "Lana Kane")
let poovey = Employee2(name: "Pam Poovey", vacationRemaining: 35)
print(kane)
print(poovey)

//*** How to compute property values dynamically ***

struct SimpleEmployee {
    let name: String
    var vacation: Int
}

var archer4 = SimpleEmployee(name: "Sterling Archer", vacation: 14)
archer4.vacation -= 5
print(archer4.vacation)
archer4.vacation -= 3
print(archer4.vacation)
//we lose the intial value of vacation


//add two variables for computer property
struct EmployeeDynamic {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    //add computed propety to avoid directly mutating the intial value pf vacationAllocated
    //we cannot write to this e.g. vacationRemaining = 50
    //to remedy this we need to use getter (code that reads) and setter (code that writes)
    //👀 Computed properties must always have an explicit type.
    // Constants cannot be computed properties.
    var vacationRemaining: Int {
        vacationAllocated - vacationTaken
    }
}

var archer5 = EmployeeDynamic(name: "Sterling Archer", vacationAllocated: 14)
archer5.vacationTaken += 4
print(archer5.vacationRemaining)
archer5.vacationTaken += 4
print(archer5.vacationRemaining)
print(archer5)

struct EmployeeGetSet {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }
        //newValue is reserved word inside setter
        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

var archer6 = EmployeeGetSet(name: "Sterling Archer", vacationAllocated: 14)
archer6.vacationTaken += 4
//use setter
archer6.vacationRemaining = 5
print(archer6.vacationAllocated)

// *** How to take action when a property changes ***

//Swift lets us create property observers, which are special pieces of code that run when properties change. These take two forms: a didSet observer to run when the property just changed, and a willSet observer to run before the property changed.

//The most important reason is convenience: using a property observer means your functionality will be executed whenever the property changes. Sure, you could use a function to do that, but would you remember? Always? In every place you change the property?

//There is one place where using a property observer is a bad idea, and that’s if you put slow work in there. If you had a User struct with an age integer, you would expect that changing age would take place virtually instantly – it’s just a number, after all. If you attach a didSet property observer that does all sorts of slow work, then suddenly changing a single integer could take way longer than you expected, and it could cause all sorts of problems for you.

struct Game {
    var score = 0
}

var game = Game()
game.score += 10
print("Score is now \(game.score)")
game.score -= 3
print("Score is now \(game.score)")
game.score += 1
//forgot to print....how to solve?
//use didSet!

struct Game2 {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var game2 = Game2()
game2.score += 10
game2.score -= 3
game2.score += 1


struct App {
    var contacts = [String]() {
        //willSet variant that runs some code before the property changes
        //provides the new value that will be assigned in case you want to take different action based on that.
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }
        //Swift automatically provides the constant oldValue inside didSet, in case you need to have custom functionality based on what you were changing from
        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")

//In practice, willSet is used much less than didSet, but you might still see it from time to time so it’s important you know it exists. Regardless of which you choose, please try to avoid putting too much work into property observers – if something that looks trivial such as game.score += 1 triggers intensive work, it will catch you out on a regular basis and cause all sorts of performance problems.

// *** How to create custom initializers ***

struct Player {
    let name: String
    let number: Int
}

//memberwise initializer, which is a fancy way of saying an initializer that accepts each properties in the order it was defined.
let player = Player(name: "Megan R", number: 15)

struct Player2 {
    let name: String
    let number: Int
    //There is no func keyword. Yes, this looks like a function in terms of its syntax, but Swift treats initializers specially.
    //initializers never explicitly have a return type – they always return the type of data they belong to.
    init(name: String, number: Int) {
        //I’ve used self to assign parameters to properties to clarify we mean “assign the name parameter to my name property”.
        self.name = name
        self.number = number
    }
}


struct Player3 {
    let name: String
    let number: Int

    init(name: String) {
        self.name = name
        //we could say that you must provide a player name, but the shirt number is randomized:
        number = Int.random(in: 1...99)
    }
}

let player6 = Player3(name: "Megan R")
print(player6.number)

//Just remember the golden rule:  👀 all properties must have a value by the time the initializer ends. If we had not provided a value for number inside the initializer, Swift would refuse to build our code.
//You can add multiple initializers to your structs if you want, as well as leveraging features such as external parameter names and default values. However, as soon as you implement your own custom initializers you’ll lose access to Swift’s generated memberwise initializer unless you take extra steps to retain it. This isn’t an accident: if you have a custom initializer, Swift effectively assumes that’s because you have some special way to initialize your properties, which means the default one should no longer be available.


//*** How to limit access to internal data using access control ***

//, maybe you have some logic you need to apply before touching yourproperties or maybe you know that some methods need to be called in a certain way or order, and so shouldn’t be touched externally.

struct BankAccount {
    var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)

if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}

//But the funds properties is just exposed to us externally, so what’s stopping us from touching it directly? The answer is nothing at all – this kind of code is allowed:

account.funds -= 1000

//To solve this, use private

struct BankAccountFixed {
    //And now accessing funds from outside the struct isn’t possible, but it is possible inside both deposit() and withdraw(). If you try to read or write funds from outside the struct Swift will refuse to build your code.
    private(set) var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var myAccount = BankAccountFixed()
myAccount.withdraw(amount: 200)

//Use private for “don’t let anything outside the struct use this.”
//Use fileprivate for “don’t let anything outside the current file use this.”
//Use public for “let anyone, anywhere use this.”
//Use private(set) Everyone can read but only inside the struct can write
    // If we had used that with BankAccount, it would mean we could print account.funds outside of the struct, but only deposit() and withdraw() could actually change the value.eeeerereeeeeee

//👀 Important: If you use private access control for one or more properties, chances are you’ll need to create your own initializer.

//*** Static properties and methods ***

struct School {
    static var studentCount = 0
    //no need for mutating keyword on static method
    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

School.add(student: "Taylor Swift")
print(School.studentCount)

//If you want to mix and match static and non-static properties and methods, there are two rules:
//1. To access non-static code from static code… you’re out of luck: static properties and methods can’t refer to non-static properties and methods because it just doesn’t make sense – which instance of School would you be referring to?
//2. To access static code from non-static code, always use your type’s name such as School.studentCount. You can also use Self to refer to the current type.

//Tip: It’s easy to forget the difference between 👀 self and Sel , but if you think about it it’s just like the rest of Swift’s naming – we start all our data types with a capital letter (Int, Double, Bool, etc), so it makes sense for Self to start with a capital letter too.

//I use static properties to organize common data in my apps. For example, I might have a struct like AppData to store lots of shared values I use in many places:
struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}

//second reason I commonly use static data is to create examples of my structs. As you’ll see later on, SwiftUI works best when it can show previews of your app as you develop, and those previews often require sampledata
//Using this approach, everywhere I need to check or display something like my app’s version number – an about screen, debug output, logging information, support emails, etc – I can read AppData.version.
struct Employee5 {
    let username: String
    let password: String

    static let example = Employee5(username: "cfederighi", password: "hairforceone")
}
//And now whenever you need an Employee instance to work with in your design previews, you can use Employee.example and you’re done.

// *** Checkpoint 6 ***
// create a struct to store information about a car, including its model, number of seats, and current G, then add a method to change gears up or down. Have a think about variables and access control: what data should be a variable rather than a constant, and whatdatashould be exposed publicly? Should the gear-changing method validate its input somehow?

struct Car {
    let model: String
    let numSeats: Int
    private(set) var currentGear = 1
    enum ShiftDirection {
        case up, down
    }
    public mutating func shift(shiftDirection: ShiftDirection) {
        switch shiftDirection {
        case .up : currentGear = currentGear == 5 ? 5 : currentGear + 1
        case .down : currentGear = currentGear == 1 ? 1 : currentGear - 1
        }
    }
}


var truck = Car(model: "Ford F150", numSeats: 3)
truck.currentGear
truck.shift(shiftDirection: .up)
truck.shift(shiftDirection: .up)
truck.shift(shiftDirection: .up)
truck.shift(shiftDirection: .up)
truck.shift(shiftDirection: .up)
truck.shift(shiftDirection: .up)
truck.currentGear
truck.shift(shiftDirection: .down)
truck.shift(shiftDirection: .down)
truck.shift(shiftDirection: .down)
truck.shift(shiftDirection: .down)
truck.shift(shiftDirection: .down)
truck.shift(shiftDirection: .down)
truck.shift(shiftDirection: .down)
truck.currentGear

// *** How to create your own classes ***

//diffs from structures
//no memberwise init
//change const properties
//mulitple instances classes all point to same data
//when all instances, deintializer will clean up left over data

class GameClass {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = GameClass()
newGame.score += 10

// *** How to make one class inherit from another ***

class EmployeeClass {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

// final = can inheret from parent but no subclass will inheret from Developer
// good strategy to make final by default
// I think many people instinctively declare their classes as final to mean “you shouldn’t subclass from this unless I specifically allow it.” I certainly do this a lot, because it’s another way I can help folks understand how my code works.
final class Developer: EmployeeClass {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    //override inherited method
    //In UIKit, Apple’s original user interface framework for iOS, this approach was used a lot.
    //Swift developers would create subclasses of Apple’s table and override the parts they wanted to change, giving them all the built-in functionality and lots of flexibility and control.
    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
    }

}

class Manager: EmployeeClass {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()

let novall = Developer(hours: 8)
novall.printSummary()

// *** How to add initializers for classes ***

// Swift won’t automatically generate a memberwise initializer for classes - with or without inheritance
// either need to write your own initializer, or provide default values for all the properties of the class.

class Vehicle2 {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car2: Vehicle2 {
    let isConvertible: Bool

    init(isElectric: Bool, isConvertible: Bool) {
        //set up own properties then parent's
        self.isConvertible = isConvertible
        //super for parent
        super.init(isElectric: isElectric)
    }
}

let teslaX = Car2(isElectric: true, isConvertible: false)

//if no custom intializer, will automatically inherent intializer of parents
class Car3: Vehicle2 {
    let isConvertiable = false
}

let car5 = Car3(isElectric: false)

// *** How to copy classes ***

//In Swift, all copies of a class instance share the same data, meaning that any changes you make to one copy will automatically change the other copies. This happens because classes are reference types in Swift, which means all copies of a class all refer back to the same underlying pot of data.

class User2 {
    var username = "Anonymous"
}

var user1 = User2()

var user10 = user1
user10.username = "Taylor"

print(user1.username)
print(user10.username)

//classes share data, while structs do not

//If you want to create a unique copy of a class instance – sometimes called a deep copy – you need to handle creating a new instance and copy across all your data safely.


//If you want to create a unique copy of a class instance – sometimes called a deep copy – you need to handle creating a new instance and copy across all your data safely.
class OtherUser {
    var username = "Anonymous"
    //Now we can safely call copy() to get an object with the same starting data, but any future changes won’t impact the original.
    func copy() -> User2 {
        let user = User2()
        user.username = username
        return user
    }
}

let thisUser = OtherUser()
//now we can call copy
let user5 = thisUser.copy()
user5.username = "Taylor"

print(thisUser.username)
print(user5.username)

// *** How to create a deinitializer for a class ***

////Just like initializers, you don’t use func with deinitializers – they are special.
//Deinitializers can never take parameters or return data, and as a result aren’t even written with parentheses.
//Your deinitializer will automatically be called when the final copy of a class instance is destroyed. That might mean it was created inside a function that is now finishing, for example.
//We never call deinitializers directly; they are handled automatically by the system.
//Structs don’t have deinitializers, because you can’t copy them. Structs are always unique.

class MyUser {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}

for i in 1...3 {
    //user inside will be destroyed when one loop iteration ends
    let user = MyUser(id: i)
    print("User \(user.id): I'm in control!")
}


var users = [MyUser]()

for i in 1...3 {
    let user = MyUser(id: i)
    print("User \(user.id): I'm in control!")
    users.append(user)
}

print("Loop is finished!")
//users won't be destryed until array is cleared with users.removeAll()
users.removeAll()
print("Array is clear!")

// *** How to work with variables inside classes ***

class TheUser {
    //note we use var
    var name = "Paul"
}

//use constant so always pointing to the same user
let user8 = TheUser()
//use var for name prop, so can change
user8.name = "Taylor"
print(user8.name)
//Think of it like this: we created a constant signpoint pointing towards a user, but we erased that user’s name tag and wrote in a different name. The user in question hasn’t changed – the person still exists – but a part of their internal data has changed.

//in contrast, use var inside the class
class TheRealUser {
    var name = "Paul"
}

//use var, so can point to different users
var user11 = TheRealUser()
user11.name = "Taylor"
print(user11.name)
//now ppint to a different user
user11 = TheRealUser()
print(user11.name)
//ow we’d be able to change theproperty but we’d also be able to change to a wholly new User instance if we wanted. To continue the signpost analogy, it would be like turning the signpost to point at wholly different person.
//
//Constant instance, constant property – a signpost that always points to the same user, who always has the same name.
//Constant instance, variable property – a signpost that always points to the same user, but their name can change.
//Variable instance, constant property – a signpost that can point to different users, but their names never change.
//Variable instance, variable property – a signpost that can point to different users, and those users can also change their name

// One upside to all this is that classes don’t need to use the mutating keyword with methods that change their data. This keyword is really important for structs because constant structs cannot have their properties changed no matter how they were created, so when Swift sees us calling a mutating method on a constant struct instance it knows that shouldn’t be allowed.

//remember let struct CAN NEVER CHANGE, so cannot call a mutating function for instnace.

// *** Summary Classes ***

// 👀 Classes aren’t quite as commonly used as structs, but they serve an invaluable purpose for sharing data, and if you ever choose to learn Apple’s older 🔥 UIKit 🔥 framework you’ll find yourself using them extensively.

//First, classes can inherit from other classes, which means they get access to the properties and methods of their parent class. You can optionally override methods in child classes if you want, or mark a class as being final to stop others subclassing it.

//Second, Swift doesn’t generate a memberwise initializer for classes, so you need to do it yourself. If a subclass has its own initializer, it must always call the parent class’s initializer at some point.

//Third, if you create a class instance then take copies of it, all those copies point back to the same instance. This means changing some data in one of the copies changes them all.

//Fourth, classes can have deinitializers that run when the last copy of one instance is destroyed.

//Finally, variable properties inside class instances can be changed regardless of whether the instance itself was created as variable.

// *** Checkpoint 7 ***

//Your challenge is this: make a class hierarchy for animals, starting with Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle as subclasses of Dog, and Persian and Lion as subclasses of Cat.
//But there’s more:
//
//The Animal class should have a legs integer property that tracks how many legs the animal has.
//The Dog class should have a speak() method that prints a generic dog barking string, but each of the subclasses should print something slightly different.
//The Cat class should have a matching speak() method, again with each subclass printing something different.
//The Cat class should have an isTame Boolean property, provided using an initializer.

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
   func speak(){
        print("Woof woof")
    }
}

class Corgi: Dog {
    override func speak(){
        print("yip yip")
    }
}

class Poddle: Dog {
    override func speak() {
        print("Bow wow")
    }
}

class Cat: Animal {
    var isTame: Bool
    func speak(){
        print("Meow")
    }
    init(legs: Int, isTame: Bool){
        self.isTame = isTame
        super.init(legs: legs)
    }
}

class Lion: Cat {
    override func speak() {
        print("Roar!")
    }
}

class Persion: Cat {
    override func speak() {
        print("mew mew")
    }
}

let myDog = Dog(legs: 4)
myDog.speak()
let myCat = Cat(legs: 4, isTame: false)
myCat.speak()
let myLion = Lion(legs: 4, isTame: false)
myLion.speak()

// *** How to create and use protocols ***

protocol Vehicle {
    //That might mean it’s a constant, but it might also be a computed property with a getter.
    var name: String { get }
    //An integer called currentPassengers, which must be read-write. That might mean it’s a variable, but it might also be a computed property with a getter and setter.
    //if you use { get set } then you can’t conform to the protocol using a constant property.
    var currentPassengers: Int { get set }
    //no implementation of functions, just fnuuction names, parameters and return type
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

//structCarPro conforms to vehicle protocol
struct CarPro: Vehicle {
    let name = "Car"
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }
    //The openSunroof() method doesn’t come from the Vehicle protocol, and doesn’t really make sense there because many vehicle types don’t have a sunroof. But that’s okay, because the protocol describes only the minimum functionality conforming types must have, and they can add their own as needed.
    func openSunroof() {
        print("It's a nice day!")
    }
}



//  👀 note: "using vehicle" <- using is the public, external parameter, while vehicle is the prviate, internal parameter
// func funcName(publicName privateName: Int) {}
//not how we ares using Vehicle as the type of second parameter! Not car!
func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = CarPro()
commute(distance: 100, using: car)

struct Bicycle: Vehicle {
    let name = "Bicycle"
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }

    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}

let bike = Bicycle()
//we are using the same commute fuction, but swift knows which functions from which structure to use (either from car or bike)
commute(distance: 50, using: bike)


func getTravelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}

getTravelEstimates(using: [car, bike], distance: 150)

//Tip: You can conform to as many protocols as you need, just by listing them one by one separated with a comma. If you ever need to subclass something and conform to a protocol, you should put the parent class name first, then write your protocols afterwards.


// *** How to use opaque return types ***

func getRandomNumber() -> some Equatable {
    //using some allow use to later change this Double.random
    //gives us flexiblity without breaking our card when we change
    //we can change our mind
    //if we had using Int, we would have to make a ton of changes
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomNumber() == getRandomNumber())

//It’s a subtle distinction, but returning Vehicle means "any sort of Vehicle type but we don't know what", whereas returning some Vehicle means "a specific sort of Vehicle type but we don't want to say which one.”
//So, when you see some View in your SwiftUI code, it’s effectively us telling Swift “this is going to send back some kind of view to lay out, but I don’t want to write out the exact thing – you figure it out for yourself.”

// ** How to create and use extensions **

//extensions make your code easier to write, easier to read, and easier to maintain in the long term.

var quote2 = "   The truth is rarely pure and never simple   "
//The .whitespacesAndNewlines value comes from Apple’s Foundation API, and actually so does trimmingCharacters(in:)
let trimmed = quote2.trimmingCharacters(in: .whitespacesAndNewlines)

//return a new string
extension String {
    func trimmed() -> String {
        //Notice how we can use self here – that automatically refers to the current string. This is possible because we’re currently in a string extension.
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

let trimmed2 = quote2.trimmed()
print(trimmed2)

//alternative with global func
func trim(_ string: String) -> String {
    string.trimmingCharacters(in: .whitespacesAndNewlines)
}

let trimmed3 = trim(quote2)

//so why? Code completion!
//Writing global functions makes your code rather messy – they are hard to organize and hard to keep track of. On the other hand, extensions are naturally grouped by the data type they are extending.
//Because your extension methods are a full part of the original type, they get full access to the type’s internal data. That means they can use properties and methods marked with private access control, for example.

//return same string
extension String {
    mutating func trim() -> String {
        //Notice how we can use self here – that automatically refers to the current string. This is possible because we’re currently in a string extension.
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

quote2.trim()

//👀 What’s more, extensions make it easier to modify values in place – i.e., to change a value directly, rather than return a new value.
//: 👀 if you’re returning a new value rather than changing it in place, you should use word endings like ed or ing, like reversed().
//trim = same value, trimmed/trimming = new value


//You can also use extensions to add computed properties, not stored properties. Why? Adding new stored properties would affect the actual size of the data types – if we added a bunch of stored properties to an integer then every integer everywhere would need to take up more space in memory, which would cause all sorts of problems.

extension String {
    //computed property
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
    var spaces: [String] {
        self.components(separatedBy: " ")
    }
}

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""
//as extending property, no need for () func call.
print(lyrics.lines.count)
print(lyrics.spaces.count)

//you can even extend inits
struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

let lotr = Book(title: "Lord of the Rings", pageCount: 1178, readingHours: 24)

// OOP vs. Protocol Oriented Programming
// important difference between the two is one of mindset: POP developers lean heavily on the protocol extension functionality of Swift to build types that get a lot of their behavior from protocols. This makes it easier to share functionality across many types, which in turn lets us build bigger, more powerful software without having to write so much code.
// not a difference between composing vs. inheritance as OOP prefers composing as well

// *** Checkpoint 8 ***

//make a protocol that describes a building, adding various properties and methods, then create two structs, House and Office, that conform to it. Your protocol should require the following:

//A property storing how many rooms it has.
//A property storing the cost as an integer (e.g. 500,000 for a building costing $500,000.)
//A property storing the name of the estate agent responsible for selling the building.
//A method for printing the sales summary of the building, describing what it is along with its other properties.

protocol Building {
    var rooms: Int {get}
    var cost: Int {get}
    var agent: String {get set}
    func salesSummary() -> Void
}

struct House: Building {
    var rooms: Int
    var cost: Int
    var agent: String
    init(rooms: Int, cost: Int, agent: String){
        self.rooms = rooms
        self.cost = cost
        self.agent = agent
    }
    func salesSummary() {
        print("This house is with \(rooms) rooms, cost \(cost) and is being handled by estate agent \(agent)")
    }
}

struct Office: Building {
    var rooms: Int
    var cost: Int
    var agent: String
    init(rooms: Int, cost: Int, agent: String){
        self.rooms = rooms
        self.cost = cost
        self.agent = agent
    }
    func salesSummary() {
        print("This office is with \(rooms) rooms, cost \(cost) and is being handled by estate agent \(agent)")
    }
}

var myOffice = Office(rooms: 1, cost: 20_000, agent: "Frank")
myOffice.salesSummary()
var myHouse = House(rooms: 3, cost: 200_000, agent: "Anne")
myHouse.salesSummary()
myHouse.agent = "Mary"
myHouse.salesSummary()

// *** How to get the most from protocol extensions ***

extension Int {
    func squared() -> Int {
        self * self
    }
}

let wholeNumber = 5
print(wholeNumber.squared())

//how to work with both int and double?
//extension Numeric {
    // this won't work as the return won't necesarily be an int, could be a double!
//    func squared() -> Int {
//        self * self
//    }
//}

extension Numeric {
    //to remedy possibility of either a double or int, use self as return type
    func squared() -> Self {
        self * self
    }
}
//
//Equtable (which is inherited from Comparable <- it will compare all the properties of one object against the same properties in the other object
// Comparable <- allows Swift to see if one object should be sorted before another.
struct User: Comparable {
    let name: String
}

// Swift can’t automatically implement Comprable in our custom types, needs a function called < that accepts two instances of your struct as its parameter, and returns true if the first instance should be sorted before the second.
// the < function can be implemented as a static function that helps keep your code a little more organized.
func <(lhs: User, rhs: User) -> Bool {
    lhs.name < rhs.name
}

let user14 = User(name: "Link")
let user22 = User(name: "Zelda")
print(user14 == user22)
print(user14 != user22)
print(user14 < user22)

// *** How to handle missing data with optionals ***

let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"
]

let peachOpposite = opposites["Peach"] //nil <- String? <- optional string

//you must unwrap the optional, if you want to use it.
if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}

if let peachOpposite = opposites["Peach"]{
    print("We got a character: \(peachOpposite)")
} else {
    print("The optional was empty.")
}

var username2: String? = nil

if let unwrappedName = username2 {
    print("We got a user: \(unwrappedName)")
} else {
    print("The optional was empty.")
}


func square(number: Int) -> Int {
    number * number
}

//create an optional integer
var number6: Int? = nil
//print(square(number: number6)) <- this won't be work, we mut unwrap the optional

if let unwrappedNumber = number6 {
    //run only if non-nil
    print(square(number: unwrappedNumber))
}

// common pattern to unwrap optional using a constant with the same variable name
// we are temporarily creating a new local constant inside the function
// called shadowing
if let number6 = number6 {
    //unwrapped value to work with inside function bodty
    print(square(number: number6))
}

// Swift didn't introduce optionals. It introduced non-optionals.

// ***  How to unwrap optionals with guard ***

//guard let is designed to exit the current function, loop, or condition if the check fails, so any values you unwrap using it will stay around after the check.

func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")
        return
    }

    print("\(number) x \(number) is \(number * number)")
}

var myVar: Int? = 3

//if let unwrapped = myVar {
//    // Run if myVar has a vlaue inside
//    print("Run if myVar has a value inside.")
//}

//guard let unwrapped = myVar else {
//    //Run if myVar is nil
//    print("Run if myVar doesn't have a value inside")
//}

func printSquare2(of number: Int?) {
    guard let number = number else {
        print("Missing input")
        //  We *must* exit the function here
        return
    }
    // `number` is still available outside of `guard`
    print("\(number) x \(number) is \(number * number)")
}

//you can even use guard with non-optionals! 😊

//use if let if you just want to unwrap some optionals, but prefer guard let if you’re specifically checking that conditions are correct before continuing.

func getMeaningOfLife() -> Int? {
    42
}

func printMeaningOfLifeIf() {
    if let name = getMeaningOfLife() {
        print(name)
    }
}

func printMeaningOfLifeGuard() {
    //It’s common to see guard used one or more times at the start of methods, because it’s used to verify some conditions are correct up front. This makes our code easier to read than if we tried to check a condition then run some code, then check another condition and run some different code.
    guard let name = getMeaningOfLife() else {
        //guard requires that we exit the current scope when it’s used, which in this case means we must return from the function if it fails. This is not optional: Swift won’t compile our code without the return.
        return
    }
    //It lets us focus on the “happy path” – the behavior of our function when everything has gone to plan, which is to print the meaning of life.
    print(name)
}

// *** How to unwrap optionals with nil coalescing ***

//This is extraordinarily useful in Swift, because although optionals are a great feature it’s usually better to have a non-optional – to have a real string rather than a “might be a string, might be nil” – and nil coalescing is a great way to get that.

let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

// If the optional has a value inside it will be sent back and stored in new, but if it doesn’t then “N/A” will be used instead.
let new = captains["Serenity"] ?? "N/A"
//n’t we just specify a default value when reading from the dictionary? If you’re thinking that you’re absolutely correct:
let new2 = captains["Serenity", default: "N/A"]

let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
let favorite = tvShows.randomElement() ?? "None"

//Or perhaps you have a struct with an optional property, and want to provide a sensible default for when it’s missing:
struct TheBook {
    let title: String
    let author: String?
}

let book = TheBook(title: "Beowulf", author: nil)
let author = book.author ?? "Anonymous"
print(author)

//It’s even useful if you create an integer from a string, where you actually get back an optional Int? because the conversion might have failed
let input = ""
let number4 = Int(input) ?? 0
print(number4)

// *** How to handle multiple optionals using optional chaining ***

//Swift’s optional chaining lets us dig through several layers of optionals in a single line of code, and if any one of those layers is nil then the whole line becomes nil.

let theNames = ["Arya", "Bran", "Robb", "Sansa"]

let chosen = theNames.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")

struct ThisBook {
    let title: String
    let author: String?
}

var thisBook: ThisBook? = nil
let thisAuthor = thisBook?.author?.first?.uppercased() ?? "A"
print(thisAuthor)

// *** How to handle function failure with optionals ***

//If a function might throw errors, you can convert it into an optional using try? – you’ll either get back the function’s return value, or nil if an error is thrown.


//hen we call a function that might throw errors, we either call it using try and handle errors appropriately, or if we’re certain the function will not fail we use try! and accept that if we were wrong our code will crash. (Spoiler: you should use try! very rarely.)
// In constrast try?, However, if all we care about is whether the function succeeded or failed, we can use an optional try to have the function return an optional value.
//If error occurs, the function will return nil, otherwise you'll return the value wrapped in an optional

enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
}

//note extra parans for nil coalescing with try?
let user232 = (try? getUser(id: 23)) ?? "Anonymous"
print(user232)


// Try? is often sued in three places

//In combination with guard let to exit the current function if the try? call returns nil.
//In combination with nil coalescing to attempt something or provide a default value on failure.
//When calling any throwing function without a return value, when you genuinely don’t care if it succeeded or not – maybe you’re writing to a log file or sending analytics to a server, for example.

//So, rather than writing this:


//do {
//    let result = try runRiskyFunction()
//    print(result)
//} catch {
//    // it failed!
//}
////You can instead write this:
//
//if let result = try? runRiskyFunction() {
//    print(result)
//}

enum PasswordError1: Error {
    case obvious
}

func checkPassword (password: String) throws -> Bool
    {
    if password == "password" {
        throw PasswordError1.obvious
    }
    return true
}

do {
//    When using try you must catch all errors that can be thrown.
    try checkPassword(password: "password")
    print("That password looks good")
} catch {
    print("You can't use that password")
}

//Using try? converts a function's return value into an optional.
if let result = try? checkPassword(password: "password") {
    print("Result was \(result)")
    //elese isn't required
} else {
    print("D'oh")
}

try! checkPassword("sekret")
print("OK")

// *** Checkpoiint 9 ***

//write a function that accepts an optional array of integers, and returns one randomly. If the array is missing or empty, return a random number in the range 1 through 100.
//
//If that sounds easy, it’s because I haven’t explained the catch yet: I want you to write your function in a single line of code. No, that doesn’t mean you should just write lots of code then remove all the line breaks – you should be able to write this whole thing in one line of code.

func getRando(arr: [Int]?) -> Int { arr?.randomElement() ?? Int.random(in: 1...100)}

let myArr: [Int]? = nil
let hisArr = [1,2,3,4]
getRando(arr: myArr)
getRando(arr: hisArr)
