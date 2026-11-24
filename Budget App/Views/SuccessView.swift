//
//  SuccessView.swift
//  Budget App
//
//  Created by Sonnie on 24/11/2026.
//

import SwiftUI

struct SuccessView: View {
    @ObservedObject var budgetViewModel: BudgetViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.secondaryGreen)
                .scaledToFill()
                .frame(width: 40, height: 40)
            
            successText
            
            Divider()
            
            transactionDetails
            
            Spacer()
            
            actionButtons
            
        }
        .padding()
        .navigationDestination(isPresented: $budgetViewModel.showHome) {
            HomeView()
        }
        
        
    }
    
    var successText: some View {
        VStack(alignment: .center, spacing: 10) {
            TextComponent(text: "Budget Item Added", fontSize: 14, fontWeight: .semibold, textColor: .secondary)
            
            TextComponent(text: "Budget item has been added successfully", fontSize: 13, fontWeight: .regular, textColor: .gray)
            
        }
    }
    
    var transactionDetails: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                TextComponent(text: "Budget Item Name", fontSize: 14, fontWeight: .semibold, textColor: .gray)
                
                Spacer()
                
                TextComponent(text: budgetViewModel.itemName, fontSize: 13, fontWeight: .regular, textColor: .black)
            }
            
            HStack {
                TextComponent(text: "Amount", fontSize: 14, fontWeight: .semibold, textColor: .black)
                
                Spacer()
                
                TextComponent(text: "\(budgetViewModel.currency) \(budgetViewModel.allocation)", fontSize: 13, fontWeight: .regular, textColor: .green)
            }
            
            HStack {
                TextComponent(text: "Date", fontSize: 14, fontWeight: .semibold, textColor: .gray)
                
                Spacer()
                
                TextComponent(text: Date().formatted(date: .complete, time: .omitted), fontSize: 13, fontWeight: .regular, textColor: .black)
            }
            
        }
    }
    
    var actionButtons: some View {
        VStack(alignment: .center, spacing: 15) {
            Button {
                budgetViewModel.clearForm()
                budgetViewModel.showHome = true
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.secondaryGreen)
                    
                    TextComponent(text: "Go back Home", fontSize: 14, fontWeight: .medium, textColor: .white)
                }
                .frame(height: 45)
            }
            
            Button {} label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.accent, lineWidth: 1)
                    
                    TextComponent(text: "Rate your Experience", fontSize: 14, fontWeight: .medium, textColor: .accent)
                }
                .frame(height: 45)
            }
        }
        .padding(.bottom)
        
    }
    
    
}

#Preview {
    SuccessView(budgetViewModel: BudgetViewModel())
}
