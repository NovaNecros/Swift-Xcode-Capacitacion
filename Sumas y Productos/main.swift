import Foundation

func factorial(n : Int, memoria : inout [Int]) -> Int
{
    if memoria.count <= n
    {
        memoria.append(n*factorial(n: n-1, memoria: &memoria))
    }
    
    return memoria[n]
}

func senoSuma(x : Double, n : Int, memoria : inout [Int]) -> Double
{
    var s : Double = 0
    var si : Double
    
    for i in 0...n
    {
        si = pow(x, Double(2*i+1)) / Double(factorial(n: 2*i+1, memoria: &memoria))
        
        if i % 2 == 0
        {
            s += si
        }
        else
        {
            s -= si
        }
    }
    return s
}

func senoProducto(x : Double, n : Int) -> Double
{
    var p : Double = x
    
    for i in 1...n
    {
        p *= (1 - pow(x/(Double(i)*Double.pi), 2))
    }
    
    return p
}

print("x = ")
let x : Double = Double(readLine() ?? "0") ?? 0
let n : Int = 7
var factoriales : [Int] = [1]

let exacto : Double = sin(x)
let suma : Double = senoSuma(x: x, n: n, memoria: &factoriales)
let producto : Double = senoProducto(x: x, n: 1000)

print()
print("sin(\(x)) =")
print("\t \(exacto)")
print("\t \(suma)")
print("\t \(producto)")
print()
print("(\(2*n+1)!) = ")
print(factoriales)

