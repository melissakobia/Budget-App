import SwiftUI

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
            SuccessView()
        }
    }

    private var categoryView: some View {
        DropdownFieldView(
            title: "Category",
            placeholder: "Select a category",
            options: Category.allCases,
            selected: $budgetViewModel.category,
            labelProvider: { $0.rawValue }
        )
    }

    private var nameView: some View {
        FormInputView(
            title: "Item Name",
            placeholder: "Enter item name",
            keyboardType: .default,
            hasCurrencyPicker: false,
            selectedCurrency: $budgetViewModel.currency,
            text: $budgetViewModel.itemName
        )
    }

    private var amountView: some View {
        FormInputView(
            title: "Amount",
            placeholder: "Enter amount",
            keyboardType: .decimalPad,
            hasCurrencyPicker: true,
            selectedCurrency: $budgetViewModel.currency,
            text: $budgetViewModel.allocation
        )
    }

    private var buttonView: some View {
        Button {
            budgetViewModel.showSuccess = budgetViewModel.addItem()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.accent)
                TextComponent(text: "Create New Budget", fontSize: 14, fontWeight: .medium, textColor: .black)
            }
            .frame(height: 45)
        }
    }
}
