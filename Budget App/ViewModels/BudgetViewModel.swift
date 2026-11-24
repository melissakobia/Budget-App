//
//  BudgetViewModel.swift
//  Budget App
//
//  Created by Sonnie on 24/11/2026.
//

import Foundation
import SwiftData
import SwiftUI
internal import Combine


@MainActor
class BudgetViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var showSuccess: Bool = false
    @Published var category: Category = .none
    @Published var allocation: String = ""
    @Published var itemName: String = ""
    @Published var currency: Currency = .kes
    @Published var showHome: Bool = false
    
    @Published var transactions: [Transaction] = [
        Transaction(image: "kfc", amount: 200, date: Date(), title: "KFC chicken", category: .food, currency: .kes),
        Transaction(image: "naivas", amount: 200, date: Date(), title: "Mitumba", category: .clothing, currency: .kes),
        Transaction(image: "paul", amount: 200, date: Date(), title: "My Fees", category: .fees, currency: .kes)
    ]

    
    func addItem() {
        transactions.append(Transaction(image: "kfc", amount: Double(allocation) ?? 0.0, date: Date(), title: itemName, category: category, currency: currency))
    }
    
    func total() -> Double {
        transactions.reduce(0.0) { $0 + $1.amount }
    }
    
    
    func clearForm() {
        itemName = ""
        allocation = ""
        
    }
    
}
