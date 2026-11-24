//
//  HomeView.swift
//  Budget App
//
//  Created by Sonnie on 24/11/2026.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var budgetViewModel: BudgetViewModel
    
    var body: some View {
        ZStack {
            Color.backgroundLight.ignoresSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    headerView
                    
                    totalAmountView
                    
                    RecentTransactionsView()
                    
                }
                .padding(.vertical)
                
            }
        }
    }
    
    var headerView: some View {
        HStack(alignment: .center, spacing: 10) {
            Image("profile")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            TextComponent(text: "Welcome back Mel, 🖐 ", fontSize: 14, fontWeight: .semibold, textColor: .backgroundDark)
            
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
        .padding(.top, 10)
        
    }
    
    var totalAmountView: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 3) {
                Spacer()
                
                Text("\(budgetViewModel.total().formatted())")
                    .font(.bold(25))
                    .foregroundStyle(.white)
                
                Text("Ksh.")
                    .font(.bold(15))
                    .foregroundStyle(.white)
                
                Spacer()
            }
            
            Text("Remaining on your monthly budget")
                .font(.medium(13))
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
