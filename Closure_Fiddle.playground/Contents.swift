import Cocoa

var greeting = "Hello, playground"

func printName(name: String) -> String {
    return "Your name is \(name)"
}

printName(name: "Bobby")

//Closures are reference types! Only one copy im memory, everything points to it
var printNameClosure = {(name: String) in
    return "Your name is \(name)"
}

printNameClosure("Bobby")

