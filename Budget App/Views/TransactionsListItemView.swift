//
//  TransactionsListItemView.swift
//  Budget App
//
//  Created by Sonnie on 24/11/2026.
//

import SwiftUI

struct TransactionsListItemView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
           imageView
           
            detailsView
        
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        }
    }
    
    var imageView: some View {
        Image(transaction.image)
            .resizable()
            .scaledToFill()
            .frame(width: 45, height: 45)
            .clipShape(Circle())
    }
    
    var detailsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 10) {
                TextComponent(text: transaction.title, fontSize: 14, fontWeight: .semibold, textColor: .black)
                
                Spacer()
                
                TextComponent(text: "\(transaction.currency.rawValue). \(transaction.amount)", fontSize: 14, fontWeight: .semibold, textColor: .red)
            }
            
            
            HStack(alignment: .center, spacing: 10) {
                TextComponent(text: transaction.date.formatted(date: .abbreviated, time: .shortened), fontSize: 13, fontWeight: .regular, textColor: .gray)
                
                Spacer()
                
                TextComponent(text: transaction.category?.rawValue ?? "", fontSize: 13, fontWeight: .regular, textColor: .gray)
            }
        }
    }
}

struct TransactionsListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsListItemView(transaction: Transaction(image: "", amount: 0, date: Date(), title: ""))
    }
}
