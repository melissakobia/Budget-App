import SwiftUI
import CoreData

@main
struct Budget_AppApp: App {
    @StateObject private var budgetViewModel = BudgetViewModel()
    private let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(budgetViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
