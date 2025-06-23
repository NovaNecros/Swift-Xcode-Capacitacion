import Foundation
import Combine

class Usuario : ObservableObject
{
    @Published var nombre : String
    @Published var apellidoP : String
    @Published var apellidoM : String
    @Published var fecha : Date
    @Published var correo : String
    @Published var telefono : String
    
    init()
    {
        self.nombre = ""
        self.apellidoP = ""
        self.apellidoM = ""
        self.fecha = Date()
        self.correo = ""
        self.telefono = ""
    }
    
    init(nombre : String, apellidoP : String, fecha : Date, correo : String, telefono : String)
    {
        self.nombre = nombre
        self.apellidoP = apellidoP
        self.apellidoM = ""
        self.fecha = fecha
        self.correo = correo
        self.telefono = telefono
    }
    
    convenience init(nombre : String, apellidoP : String, apellidoM : String, fecha : Date, correo : String, telefono : String)
    {
        self.init(nombre: nombre, apellidoP: apellidoP, fecha: fecha, correo: correo, telefono: telefono)
        self.apellidoM = apellidoM
    }
    
    var description : String
    {
        return "\(nombre) \(apellidoP) \(apellidoM)\n" +
        "\(fecha.isoString)\n" +
        "\(correo)\n" +
        "\(telefono)\n"
    }
}
