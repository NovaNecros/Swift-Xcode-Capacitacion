import Foundation
import CoreData

@objc(Persona)
public class Persona : NSManagedObject
{
    public override func awakeFromInsert()
    {
        super.awakeFromInsert()
        self.id = UUID()
    }
}

extension Persona
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Persona>
    {
        NSFetchRequest<Persona>(entityName: "Persona")
    }
    
    @NSManaged public var id : UUID?
    @NSManaged public var nombre : String?
    @NSManaged public var cum : Date?
}

extension Persona : Identifiable { }
