import Foundation
import CoreData

@objc(Personita)
public class Personita : NSManagedObject
{
    public override func awakeFromInsert()
    {
        super.awakeFromInsert()
        self.id = UUID()
    }
}

extension Personita
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Personita>
    {
        NSFetchRequest<Personita>(entityName: "Personita")
    }
    
    @NSManaged public var id : UUID?
    @NSManaged public var nombre : String?
    @NSManaged public var cum : Date?
}

extension Personita : Identifiable { }
