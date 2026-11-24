//
//  DropdownFieldView.swift
//  Budget App
//
//  Created by Sonnie on 24/11/2026.
//

import SwiftUI

struct DropdownFieldView<T: Hashable>: View {
    let title: String
    var placeholder: String = ""
    var options: [T]
    @Binding var selected: T
    var labelProvider: (T) -> String
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if !title.isEmpty {
                TextComponent(text: title, fontSize: 12, fontWeight: .medium, textColor: .black)
            }
            
            Menu {
                ForEach(options, id: \.self) { option in
                    if !labelProvider(option).isEmpty {
                        Button { selected = option } label: {
                            menuRow(for: option)
                        }
                    }
                    
                }
            } label: {
                HStack {
                    
                    Text(labelProvider(selected).isEmpty ? placeholder : labelProvider(selected))
                        .font(.system(size: (labelProvider(selected).isEmpty ? 13 : 14)))
                        .foregroundStyle(labelProvider(selected).isEmpty ? Color.gray : .black)
                    
                    Spacer()
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .foregroundStyle(.gray)
                        .frame(width: 13, height: 9)
                    
                }
            }
            .padding(EdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 6))
            .padding(EdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 6))
            .background(content: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
            })
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.gray.opacity(0.2), lineWidth: 1)
            }
            
            
        }
    }
    
    /// A menu row: the option's label, plus its icon when the caller supplies one.
    @ViewBuilder
    func menuRow(for option: T) -> some View {
        Label {
            Text(labelProvider(option))
                .font(.system(size: (14)))
                .foregroundStyle(Color.black)
        } icon: {}
    }
}
