import Foundation

let PI : Double = 3.14159265358979323846

func areaCirc(r : Double) -> Double
{
    return PI * r * r
}

func areaMonteCarlo(r : Double, n : Int) -> Double
{
    var rn : Double
    var area : Double = 0
    
    for _ in 0...n
    {
        rn = Double.random(in: 0...1)
        area += sqrt(1 - rn * rn)
    }
    
    return 4 * r * r * area / Double(n)
}

print("Radio = ")
var r : Double! = Double(readLine() ?? "0")
let n : Int = 10000000

let areaE : Double = areaCirc(r : r)
let areaA : Double = areaMonteCarlo(r : r, n : n)
print("Area exacta = \(areaE)")
print("Area aproximada = \(areaA)")


