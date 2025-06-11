import Foundation

class Ejemplo : CustomStringConvertible
{
    var nombre : String
    var valor : Double
    
    init(nombre : String, valor : Double)
    {
        self.nombre = nombre
        self.valor = valor
    }
    
    var description : String
    {
        return "\(nombre) : \(valor)"
    }
}

var cosa1 : Ejemplo
cosa1 = Ejemplo(nombre : "mapache", valor : 44.3)
let cosa2 : Ejemplo = Ejemplo(nombre : "Juan", valor : 6.9)
var cosas : [Ejemplo] = [cosa1, cosa2]
cosas.append(Ejemplo(nombre : "Toyota", valor : -3.7))

print(cosas.map(\.self.description).joined(separator : "\n"))
