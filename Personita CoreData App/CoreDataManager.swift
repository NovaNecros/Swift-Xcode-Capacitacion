import Foundation
import CoreData

class CoreDataManager
{
    let columns : [String] = ["id", "nombre", "cum"]
    
    let container : NSPersistentContainer
    var viewContext : NSManagedObjectContext
    {
        container.viewContext
    }
    
    init()
    {
        container = NSPersistentContainer(name: "PersonitaModel")
        container.loadPersistentStores
        { (description, error) in
            if let error = error
            {
                fatalError("No hay base :(\n \(error.localizedDescription)")
            }
        }
    }
    
    func guardar(nombre : String, cum : Date)
    {
        let ctx : NSManagedObjectContext = container.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Personita", in: ctx)!
        let personita = Personita(entity: entity, insertInto: ctx)
        
        personita.nombre = nombre
        personita.cum = cum
        
        do
        {
            try container.viewContext.save()
        }
        catch
        {
            print("Error al guardar \n \(error.localizedDescription)")
        }
    }
    
    func borrar(_ personita : Personita)
    {
        viewContext.delete(personita)
        saveContext()
    }
    
    func leer() -> [Personita]
    {
        leer(key: nil)
    }
    
    func leer(key : String?) -> [Personita]
    {
        leer(key: key, order: true)
    }
    
    func leer(key : String?, order : Bool) -> [Personita]
    {
        let request : NSFetchRequest<Personita> = Personita.fetchRequest()
        var realKey : String? = nil
        
        for column in columns
        {
            if key == column
            {
                realKey = column
                break
            }
        }
        
        request.sortDescriptors = [NSSortDescriptor(key: realKey ?? "nombre", ascending: order)]
        
        do
        {
            return try viewContext.fetch(request)
        }
        catch
        {
            print("Error al leer\n \(error.localizedDescription)")
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
            print("Error al actualizar contexto\n \(error.localizedDescription)")
        }
    }
}

extension CoreDataManager : ObservableObject { }
