

import Foundation
import CoreData


extension Animals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Animals> {
        return NSFetchRequest<Animals>(entityName: "Animals")
    }

    @NSManaged public var title: String?
    @NSManaged public var creator: String?
    @NSManaged public var thumbnail: NSData?
    @NSManaged public var type: String?
    @NSManaged public var image: Images?

}
