import Foundation
import Combine

class Personita : ObservableObject
{
    @Published var nombre : String
    @Published var edad : Int
    
    init()
    {
        self.nombre = ""
        self.edad = -1
    }
    
    init(nombre : String, edad : Int)
    {
        self.nombre = nombre
        self.edad = edad
    }
    
    var description : String
    {
        return "Hola \(edad), tienes \(nombre) años :b"
    }
}
