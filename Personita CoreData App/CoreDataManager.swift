import Foundation
import CoreData

class CoreDataManager
{
    let container : NSPersistentContainer
    
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
            print(":)")
        }
        catch
        {
            print(":(")
        }
    }
    
    func leerTodas() -> [Personita]
    {
        let cursor : NSFetchRequest<Personita> = Personita.fetchRequest()
        
        do
        {
            return try container.viewContext.fetch(cursor)
        }
        catch
        {
            return []
        }
    }
}
