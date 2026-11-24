import Foundation

struct Transaction: Identifiable {
    var id: String
    var image: String
    var amount: Double
    var date: Date
    var title: String
    var category: Category?
    var currency: Currency

    init(id: String = UUID().uuidString, image: String, amount: Double, date: Date, title: String, category: Category? = nil, currency: Currency = .kes) {
        self.id = id
        self.image = image
        self.amount = amount
        self.date = date
        self.title = title
        self.category = category
        self.currency = currency
    }
}

enum Category: String, CaseIterable {
    case food = "Food"
    case transport = "Transport"
    case clothing = "Clothing"
    case fees = "Fees"
    case none = ""
}

enum Currency: String, CaseIterable {
    case kes = "KES"
    case usd = "USD"
}
