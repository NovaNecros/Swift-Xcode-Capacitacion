import Foundation
import Combine

class AutoViewModel : ObservableObject
{
    @Published private(set) var auto : Auto? = nil
    
    var description : String
    {
        auto?.overrideDescription ?? ""
    }
    
    func guardar(marca : String, modelo : String)
    {
        auto = Auto(marca: marca, modelo: modelo)
    }
    
    func avanzar(km : Int)
    {
        auto?.avanzar(km: km)
        objectWillChange.send()
    }
    
    func avanzar()
    {
        auto?.avanzar()
        objectWillChange.send()
    }
    
    func borrar()
    {
        self.auto = nil
    }
}
