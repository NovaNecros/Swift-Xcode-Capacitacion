import Foundation
import CoreData

class CoreDataManager
{
    let container : NSPersistentContainer
    var viewContext : NSManagedObjectContext
    {
        container.viewContext
    }
    
    let columns : [String]
    
    init()
    {
        self.container = NSPersistentContainer(name: "PeliculaModel")
        
        self.container.loadPersistentStores()
        { (description, error) in
            if let error = error
            {
                fatalError(":( \n \(error.localizedDescription)")
            }
        }
        
        guard let entity = self.container.managedObjectModel.entities.first else
        {
            self.columns = []
            return
        }
        
        self.columns = Array(entity.attributesByName.keys)
    }
    
    func guardar(titulo : String, director : String, genero : String, clasificacion : String, duracion : Double, estreno : Date, rating : Int)
    {
        let entity = NSEntityDescription.entity(forEntityName: "Pelicula", in: viewContext)!
        let peli = Pelicula(entity: entity, insertInto: viewContext)
        
        peli.titulo = titulo
        peli.director = director
        peli.genero = genero
        peli.clasificacion = clasificacion
        peli.duracion = Int16(duracion)
        peli.estreno = estreno
        peli.rating = Int16(rating)
        
        do
        {
            try container.viewContext.save()
        }
        catch
        {
            print(":( \n \(error.localizedDescription)")
        }
    }
    
    func borrar(_ peli : Pelicula)
    {
        viewContext.delete(peli)
        saveContext()
    }
    
    func leer() -> [Pelicula]
    {
        leer(key: nil)
    }
    
    func leer(key : String?) -> [Pelicula]
    {
        leer(key: key, order: true)
    }
    
    func leer(key : String?, order : Bool) -> [Pelicula]
    {
        let request : NSFetchRequest<Pelicula> = Pelicula.fetchRequest()
        var realKey : String? = nil
        
        for column in columns
        {
            if key == column
            {
                realKey = column
                break
            }
        }
        
        request.sortDescriptors = [NSSortDescriptor(key: realKey ?? "titulo", ascending: order)]
        
        do
        {
            return try viewContext.fetch(request)
        }
        catch
        {
            print(":( \n \(error.localizedDescription)")
            return []
        }
    }
    
    private func saveContext()
    {
        guard viewContext.hasChanges else { return }
        do
        {
            try viewContext.save()
        }
        catch
        {
            print(":( \n \(error.localizedDescription)")
        }
    }
}
