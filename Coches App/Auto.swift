import Foundation

class Auto : NSObject
{
    let marca : String
    let modelo : String
    var km : Int
    
    init(marca : String, modelo : String)
    {
        self.marca = marca
        self.modelo = modelo
        self.km = 0
    }
    
    init(marca : String, modelo : String, km : Int)
    {
        self.marca = marca
        self.modelo = modelo
        self.km = km
    }
    
    var overrideDescription : String
    {
        return "\(marca) \(modelo) - \(km) km"
    }
    
    func avanzar(km : Int)
    {
        self.km += km
    }
    
    func avanzar()
    {
        avanzar(km: 1)
    }
}
