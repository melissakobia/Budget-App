//
//  FormInputView.swift
//  Budget App
//
//  Created by Sonnie on 24/11/2026.
//

import SwiftUI


struct FormInputView: View {
    let title: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    var hasCurrencyPicker: Bool
    @State var selectedCurrency: Currency?
    
    @State var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextComponent(text: title, fontSize: 12, fontWeight: .medium, textColor: .black)
            
            HStack(spacing: 12) {
                if hasCurrencyPicker {
                    Menu {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Button {
                                self.selectedCurrency = currency
                            } label: {
                                TextComponent(text: currency.rawValue, fontSize: 14, fontWeight: .medium, textColor: .black)
                            }

                            
                        }
                    } label: {
                        HStack(alignment: .center, spacing: 10) {
                            TextComponent(text: selectedCurrency?.rawValue ?? "", fontSize: 14, fontWeight: .medium, textColor: .backgroundDark)
                            
                            Image(systemName: "arrowtriangle.down.fill")
                                .resizable()
                                .foregroundStyle(.gray)
                                .frame(width: 13, height: 9)
                            
                            
                        }
                        
                    }

                }
                
                TextField(
                    text: $text,
                    prompt: Text(placeholder)
                        .foregroundColor(.gray)
                        .font(.system(size: 13))
                        .fontWeight(.regular)
                ) {
                    EmptyView()
                }
                .keyboardType(keyboardType)
                .font(.system(size: 14))
            }
            .padding(EdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 6))
            .padding(EdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 6))
            .background(content: {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
            })
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.gray.opacity(0.2), lineWidth: 1)
            }
            
        }
    }
}





