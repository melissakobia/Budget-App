import CoreData
import Foundation

@objc(BudgetRecord)
final class BudgetRecord: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var title: String
    @NSManaged var amount: Double
    @NSManaged var date: Date
    @NSManaged var category: String
    @NSManaged var currency: String
}
