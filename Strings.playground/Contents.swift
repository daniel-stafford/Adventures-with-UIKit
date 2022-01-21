import UIKit

var greeting = "Hello, playground"

let name = "Taylor"

for letter in name {
    print("Give me a \(letter)!")
}

// wont work
// print(name[3])

let letter = name[name.index(name.startIndex, offsetBy: 3)]
// With that in place, we can now read name[3] just fine. However, it creates the possibility that someone might write code that loops over a string reading individual letters, which they might not realize creates a loop within a loop and has the potential to be slow.
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

let letter2 = name[3]
print(letter2)
// name.count is long
// better to use name.isEmpty much quicker

let password = "12345"
password.hasPrefix("123")
password.hasSuffix("345")

extension String {
    // remove a prefix if it exists
    func deletingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        // dropFirst = remove certain number of letters from start of string, return substring
        return String(dropFirst(prefix.count))
    }

    // remove a suffix if it exists
    func deletingSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        // dropLast = remove certain number of letters from end of string, return substring
        return String(dropLast(suffix.count))
    }
}

password.deletingPrefix("123")
password.deletingSuffix("45")

let weather = "it's going to rain"
print(weather.capitalized)

extension String {
    var capitalizedFirst: String {
        // check if string is empty (has no first letter)
        guard let firstLetter = first else { return "" }
        // first letter = string.element alias of characterbib, uppercase() = string
        return firstLetter.uppercased() + dropFirst()
    }
}

let input = "Swift is like Objective-C without the C"
input.contains("Swift")

let languages = ["Python", "Ruby", "Swift"]
languages.contains("Swift")

// check if any item in array is in input string
// this works but isn't elegant
extension String {
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if contains(item) {
                return true
            }
        }

        return false
    }
}

input.containsAny(of: languages)

// arrays have second contains(where: ), add close input,contains, which cycles through array
languages.contains(where: input.contains)

let string = "This is a test string"

// dict affecting the whole string
let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36),
]

let attributedString2 = NSAttributedString(string: string, attributes: attributes)

let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))

// Set .underlineStyle to a value from NSUnderlineStyle to strike out characters.
// Set .strikethroughStyle to a value from NSUnderlineStyle (no, that’s not a typo) to strike out characters.
// Set .paragraphStyle to an instance of NSMutableParagraphStyle to control text alignment and spacing.
// Set .link to be a URL to make clickable links in your strings.

// Set .underlineStyle to a value from NSUnderlineStyle to strike out characters.
//Set .strikethroughStyle to a value from NSUnderlineStyle (no, that’s not a typo) to strike out characters.
//Set .paragraphStyle to an instance of NSMutableParagraphStyle to control text alignment and spacing.
//Set .link to be a URL to make clickable links in your strings.

extension String {
    func withPrefix(_ prefix: String) -> String {
        guard !self.contains(prefix)  else { return self}
        return prefix + self
    }
}

"pet".withPrefix("car")

extension String {
    func isNumeric() -> Bool {
        for char in self {
            if char.isNumber {
                return true
            }
        }
        return false
    }
}

"hello1".isNumeric()
"hello".isNumeric()

extension String {
    func lines() -> [String] {
        return self.components(separatedBy: "\n")
    }
}

"this\nis\na\ntest".lines()

//Extend UIView so that it has a bounceOut(duration:) method that uses animation to scale its size down to 0.0001 over a specified number of seconds.


//Extend Int with a times() method that runs a closure as many times as the number is high. For example, 5.times { print("Hello!") } will print “Hello” five times.


//Extend Array so that it has a mutating remove(item:) method. If the item exists more than once, it should remove only the first instance it finds. Tip: you will need to add the Comparable constraint to make this work!
