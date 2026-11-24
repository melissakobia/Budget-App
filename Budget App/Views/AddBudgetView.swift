//
//  AddBudgetView.swift
//  Budget App
//
//  Created by Sonnie on 24/11/2026.
//

import SwiftUI
import SwiftData

struct AddBudgetView: View {
    @EnvironmentObject var budgetViewModel: BudgetViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                categoryView
                
                nameView
                
                amountView
                
                buttonView
            }
            .padding()
        }
        .scrollIndicators(.never)
        .navigationTitle("Add New Budget Item")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $budgetViewModel.showSuccess) {
            SuccessView(budgetViewModel: budgetViewModel)
        }
        
    }
    
    var categoryView: some View {
        
       DropdownFieldView(
        title: "Category",
        placeholder: "Select a category",
        options: Category.allCases,
        selected: $budgetViewModel.category,
        labelProvider: { $0.rawValue }
        )
        
    }
    
    var nameView: some View {
        FormInputView(
            title: "Item Name",
            placeholder: "Enter item name",
            keyboardType: .default,
            hasCurrencyPicker: false,
            text: budgetViewModel.itemName)
    }
    
    var amountView: some View {
        FormInputView(
            title: "Item Name",
            placeholder: "Enter item name",
            keyboardType: .default,
            hasCurrencyPicker: true,
            selectedCurrency: budgetViewModel.currency,
            text: budgetViewModel.allocation)
    }
    
    var buttonView: some View {
        Button {
            self.budgetViewModel.addItem()
            self.budgetViewModel.showSuccess = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.accent)
                
                TextComponent(text: "Create New Budget", fontSize: 14, fontWeight: .medium, textColor: .black)
            }
            .frame(height: 45)
        }

    }
}

#Preview {
    AddBudgetView()
}
