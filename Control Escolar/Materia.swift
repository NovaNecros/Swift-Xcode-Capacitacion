import Foundation

class Materia : CustomStringConvertible
{
    let id : Int
    let nombre : String
    var alumnos : [Alumno] = []
    var calificaciones : [Double] = []
    var promedio : Double = 0
    
    init(id : Int, nombre : String)
    {
        self.id = id
        self.nombre = nombre
    }
    
    var description : String
    {
        return "Grupo: \t \(id)" +
        "\nMateria: \t \(nombre)" +
        "\nDemanda: \t \(alumnos.count)"
    }
    
    func imprimirAlumnos()
    {
        for i in 0..<alumnos.count
        {
            print("\(i+1).\t \(alumnos[i]) \t \(calificaciones[i])")
        }
    }
    
    func calcularPromedio() -> Double
    {
        if calificaciones.isEmpty
        {
            return 0
        }
        
        var s : Double = 0
        
        for cali in calificaciones
        {
            s += cali
        }
        
        return s/Double(calificaciones.count)
    }
    
    func inscribir(alumno : Alumno)
    {
        alumnos.append(alumno)
        calificaciones.append(0)
    }
    
    func calificar(alumno : Alumno, cali : Double)
    {
        let indice : Int = alumnos.firstIndex(where: { $0.id == alumno.id })!
        calificaciones[indice] = cali
        self.promedio = calcularPromedio()
    }
}
