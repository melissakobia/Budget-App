//
//  HomeView.swift
//  Budget App
//
//  Created by Sonnie on 24/11/2026.
//

import SwiftUI

private struct SpendingCategory: Identifiable {
    let category: Category
    let title: String
    let color: Color

    var id: String { category.rawValue }
}

struct HomeView: View {
    @EnvironmentObject var budgetViewModel: BudgetViewModel
    @State private var selectedMonth = Calendar.current.dateInterval(of: .month, for: Date())?.start ?? Date()

    private let spendingCategories = [
        SpendingCategory(category: .food, title: "Food & Beverage", color: .foodBeverage),
        SpendingCategory(category: .transport, title: "Transport & Fuel", color: .transportFuel),
        SpendingCategory(category: .clothing, title: "Clothing", color: .clothingCategory),
        SpendingCategory(category: .fees, title: "Transaction Fees", color: .transactionFees)
    ]

    private var monthTransactions: [Transaction] {
        budgetViewModel.transactions.filter {
            $0.currency == .kes && Calendar.current.isDate($0.date, equalTo: selectedMonth, toGranularity: .month)
        }
    }

    private var monthlyTotal: Double {
        budgetViewModel.totalSpend(in: selectedMonth)
    }
    
    var body: some View {
        ZStack {
            Color.backgroundLight.ignoresSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    headerView
                    
                    totalAmountView

                    monthlySpendingView
                    
                    RecentTransactionsView()
                    
                }
                .padding(.vertical)
                
            }
        }
    }
    
    private var availableMonths: [Date] {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())
        return (1...12).compactMap { month in
            calendar.date(from: DateComponents(year: year, month: month, day: 1))
        }
    }

    private var barTotal: Double {
        spendingCategories.reduce(0) { $0 + amount(for: $1.category) }
    }

    private func amount(for category: Category) -> Double {
        monthTransactions
            .filter { $0.category == category }
            .reduce(0) { $0 + $1.amount }
    }

    var headerView: some View {
        HStack(alignment: .center, spacing: 10) {
            Image("profile")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            TextComponent(text: "Welcome back John Doe, 🖐 ", fontSize: 14, fontWeight: .semibold, textColor: .backgroundDark)
            
            Spacer()
            
            Image(systemName: "bell")
                .font(.regular(16))
                .foregroundStyle(.accent)
                .fontWeight(.light)
                .frame(width: 40, height: 40)
                .background {
                    Circle()
                        .stroke(.accent, lineWidth: 1)
                }
        }
        .padding(.horizontal)
        
    }

    private var monthlySpendingView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Total Spend this Month")
                        .font(.medium(14))
                        .foregroundStyle(.secondary)

                    Text("Ksh \(monthlyTotal.formatted(.number.precision(.fractionLength(1))))")
                        .font(.bold(14))
                        .foregroundStyle(.primary)
                }

                Spacer()

                Menu {
                    ForEach(availableMonths, id: \.self) { month in
                        Button(month.formatted(.dateTime.month(.wide))) {
                            selectedMonth = month
                        }
                    }
                } label: {
                    HStack(spacing: 8) {
                        Text(selectedMonth.formatted(.dateTime.month(.wide)))

                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .foregroundStyle(.gray)
                            .frame(width: 13, height: 9)
                    }
                    .font(.regular(14))
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 9)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary.opacity(0.55), lineWidth: 1)
                    }
                }
            }

            if barTotal > 0 {
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        ForEach(spendingCategories) { item in
                            let amount = amount(for: item.category)
                            if amount > 0 {
                                Rectangle()
                                    .fill(item.color)
                                    .frame(width: geometry.size.width * CGFloat(amount / barTotal))
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                }
                .frame(height: 24)
            }

            VStack(spacing: 13) {
                ForEach(spendingCategories) { item in
                    HStack(spacing: 10) {
                        Circle()
                            .fill(item.color)
                            .frame(width: 14, height: 14)

                        Text(item.title)
                            .font(.regular(14))
                            .foregroundStyle(.primary)

                        Spacer()

                        Text("Ksh. \(amount(for: item.category).formatted(.number.precision(.fractionLength(1))))")
                            .font(.regular(14))
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal)
        .background(Color.white)
        
        
    }

    var totalAmountView: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 3) {
                Spacer()
                
                Text("\(budgetViewModel.remainingBudget(in: selectedMonth).formatted())")
                    .font(.bold(30))
                    .foregroundStyle(.white)
                
                Text("Ksh.")
                    .font(.bold(15))
                    .foregroundStyle(.white)
                
                Spacer()
            }
            
            Text("Remaining from Ksh. 20,000 monthly budget")
                .font(.medium(14))
                .foregroundStyle(.white)
            
            
        }
        .padding()
        .frame(height: 150)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(colors: [.accentColor, .secondaryGreen], startPoint: .leading, endPoint: .trailing))
        }
        .padding(.horizontal)
        
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(BudgetViewModel())
    }
}
