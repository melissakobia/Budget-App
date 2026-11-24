//
//  Transaction.swift
//  Budget App
//
//  Created by Sonnie on 24/11/2026.
//

import Foundation
import SwiftData


class Transaction: Identifiable {
    
    var id = UUID().uuidString
    var image: String
    var amount: Double
    var date: Date
    var title: String
    var category: Category?
    var currency: Currency = .kes
    
    init(image: String, amount: Double, date: Date, title: String, category: Category? = nil, currency: Currency = .kes) {
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


