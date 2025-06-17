import Foundation

class Alumno : CustomStringConvertible
{
    let nombre : String
    let id : Int
    
    init(id : Int, nombre : String)
    {
        self.nombre = nombre
        self.id = id
    }
    
    var description : String
    {
        return "\(id) \t \(nombre)"
    }
}
