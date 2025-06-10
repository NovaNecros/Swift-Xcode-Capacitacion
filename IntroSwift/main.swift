import Foundation

print("Hello, World!")

var x = 3
var y : Int
y = 4
var z : Int = 3

z = y
y = x
x = 6

let x2 = 5
let y2 : Int
y2 = 5
let z2 : Int = 5

let character : Character = "a"
let string : String = "Holi"
let bool : Bool = true
let float : Float = 2.72
let double : Double = 2.727272727272727

print("Holis mundis")
print("\(x)")
print("\(y)")
print("\(z)")
print("\(x2)")
print("\(y2)")
print("\(z2)")
print("\(character)")
print("\(string)")
print("\(bool)")
print("\(float)")
print("\(double)")

print("Escribe un numero")
let input : String = readLine() ?? ""
let numero : Int = Int(input) ?? 0
print("\(numero)")

var palabra : String
var palNull : String?
palNull = nil

var arr = [1,2,3,4,5]
print(arr)
arr.append(6)
print(arr)
arr.remove(at: 2)
print(arr)

var arr2 : [Int]
arr.insert(2, at: 0)

