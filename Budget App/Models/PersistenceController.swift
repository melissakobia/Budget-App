import CoreData
import Foundation

final class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        let model = NSManagedObjectModel()
        let record = NSEntityDescription()
        record.name = "BudgetRecord"
        record.managedObjectClassName = NSStringFromClass(BudgetRecord.self)
        record.properties = [
            Self.attribute("id", type: .UUIDAttributeType),
            Self.attribute("title", type: .stringAttributeType),
            Self.attribute("amount", type: .doubleAttributeType),
            Self.attribute("date", type: .dateAttributeType),
            Self.attribute("category", type: .stringAttributeType),
            Self.attribute("currency", type: .stringAttributeType)
        ]
        model.entities = [record]

        container = NSPersistentContainer(name: "BudgetApp", managedObjectModel: model)
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load Core Data store: \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    private static func attribute(_ name: String, type: NSAttributeType) -> NSAttributeDescription {
        let value = NSAttributeDescription()
        value.name = name
        value.attributeType = type
        value.isOptional = false
        return value
    }
}
