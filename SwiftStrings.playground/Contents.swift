import Cocoa

let name = "Taylor"

for letter in name {
    print("Give me a \(letter)!")
}

// wont work
//print(name[3])



let letter = name[name.index(name.startIndex, offsetBy: 3)]
// With that in place, we can now read name[3] just fine. However, it creates the possibility that someone might write code that loops over a string reading individual letters, which they might not realize creates a loop within a loop and has the potential to be slow.
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

let letter2 = name[3]
print(letter2)
//name.count is long
//better to use name.isEmpty much quicker
