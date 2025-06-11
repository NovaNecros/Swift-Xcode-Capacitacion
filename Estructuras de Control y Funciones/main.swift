import Foundation

//Condicional if

func esMayor(edad : Int) -> Void
{
    if edad >= 18
    {
        print("\(true)")
    }
    else
    {
        print("\(false)")
    }
}

var edad : Int = 11
esMayor(edad : edad)
edad = 20
esMayor(edad : edad)


//Cicilo for

let arr : [Int] = [1,5,7,9,2,3]

for x in arr
{
    print("\(x)")
}

for i in 0...3
{
    print("\(arr[i])")
}

for x in (1...10)
{
    print("\(x)")
}

//Ciclo while
var despierto : Bool = true
var opcion : String
var ovejas : Int = 0

while(despierto)
{
    print("Estas despierto? (y/n)")
    opcion = readLine() ?? "Y"
    opcion = opcion.uppercased()
    
    if(opcion == "N")
    {
        despierto = false
        print("Contaste \(ovejas) ovejas")
    }
    else if(opcion == "Y")
    {
        ovejas += 1
    }
    else
    {
        print("???")
    }
}

func prod(x : Double, y : Double) -> Double
{
    return x*y
}

let x = 3.14, y = 2.72
let p = prod(x : y, y : x)
print("\(x)*\(y)=\(p)")
