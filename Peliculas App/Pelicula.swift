import Foundation
import CoreData

@objc(Pelicula)
public class Pelicula : NSManagedObject
{
    public override func awakeFromInsert()
    {
        super.awakeFromInsert()
        self.id = UUID()
    }
}

extension Pelicula
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pelicula>
    {
        NSFetchRequest<Pelicula>(entityName: "Pelicula")
    }
    
    @NSManaged public var id : UUID?
    @NSManaged public var titulo : String?
    @NSManaged public var director : String?
    @NSManaged public var duracion : Int16
    @NSManaged public var rating : Int16
}

extension Pelicula : Identifiable { }
