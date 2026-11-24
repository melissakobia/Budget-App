import Combine
import CoreData
import Foundation
import SwiftUI

@MainActor
final class BudgetViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var showSuccess = false
    @Published var category: Category = .none
    @Published var allocation = ""
    @Published var itemName = ""
    @Published var currency: Currency = .kes
    @Published var selectedTab: Tabs = .home
    @Published private(set) var lastAddedAt = Date()
    @Published private(set) var transactions: [Transaction]

    let monthlyBudget = 20_000.0

    private let context: NSManagedObjectContext
    private let sampleTransactions: [Transaction] = [
        Transaction(image: "kfc", amount: 200, date: Date(), title: "KFC chicken", category: .food),
        Transaction(image: "naivas", amount: 200, date: Date(), title: "Mitumba", category: .clothing),
        Transaction(image: "paul", amount: 200, date: Date(), title: "My Fees", category: .fees)
    ]

    init(context: NSManagedObjectContext? = nil) {
        self.context = context ?? PersistenceController.shared.container.viewContext
        self.transactions = []
        loadTransactions()
    }

    @discardableResult
    func addItem() -> Bool {
        let title = itemName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty, category != .none, let amount = Double(allocation), amount > 0 else { return false }

        let record = BudgetRecord(context: context)
        record.id = UUID()
        record.title = title
        record.amount = amount
        let createdAt = Date()
        record.date = createdAt
        record.category = category.rawValue
        record.currency = currency.rawValue

        do {
            try context.save()
            lastAddedAt = createdAt
            loadTransactions()
            return true
        } catch {
            context.rollback()
            return false
        }
    }

    func totalSpend(in month: Date) -> Double {
        let monthTransactions = transactions.filter {
            $0.currency == .kes && Calendar.current.isDate($0.date, equalTo: month, toGranularity: .month)
        }
        // Monthly spend only includes KES transactions from the selected month.
        return monthTransactions.reduce(0) { $0 + $1.amount }
    }

    func remainingBudget(in month: Date) -> Double {
        // The home balance is the Ksh 20,000 budget minus selected-month spend.
        monthlyBudget - totalSpend(in: month)
    }

    func clearForm() {
        itemName = ""
        allocation = ""
        category = .none
        currency = .kes
    }

    private func loadTransactions() {
        let request = NSFetchRequest<BudgetRecord>(entityName: "BudgetRecord")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let records = (try? context.fetch(request)) ?? []
        let saved = records.map { record in
            Transaction(
                id: record.id.uuidString,
                image: "total",
                amount: record.amount,
                date: record.date,
                title: record.title,
                category: Category(rawValue: record.category),
                currency: Currency(rawValue: record.currency) ?? .kes
            )
        }
        transactions = saved + sampleTransactions
    }
}
