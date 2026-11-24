//
//  TextComponent.swift
//  Budget App
//
//  Created by Sonnie on 24/11/2026.
//

import SwiftUI

struct TextComponent: View {
    let text: String
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    let textColor: Color
    
    var body: some View {
        
        Text(text)
            .font(.system(size: fontSize))
            .fontWeight(fontWeight)
            .foregroundStyle(textColor)
    }
}

#Preview {
    TextComponent(text: "", fontSize: 10, fontWeight: .light, textColor: .green)
}
