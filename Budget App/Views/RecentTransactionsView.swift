//
//  RecentTransactionsView.swift
//  Budget App
//
//  Created by Sonnie on 24/11/2026.
//

import SwiftUI

struct RecentTransactionsView: View {
    @EnvironmentObject var budgetViewModel: BudgetViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                TextComponent(text: "Recent Transactions", fontSize: 14, fontWeight: .semibold, textColor: .black)
                
                Spacer()
                
                Button {} label: {
                    TextComponent(text: "View All", fontSize: 14, fontWeight: .semibold, textColor: .green)
                }

            }
            
            VStack(alignment: .leading, spacing: 15) {
                ForEach(budgetViewModel.transactions, id: \.id) { transaction in
                    TransactionsListItemView(transaction: transaction)
                }
            }
        }
        .padding()
        .background {
            Color.white
        }
    }
    
   
}

struct RecentTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentTransactionsView().environmentObject(BudgetViewModel())
    }
}
