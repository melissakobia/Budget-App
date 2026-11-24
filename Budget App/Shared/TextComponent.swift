import SwiftUI

struct TextComponent: View {
    let text: String
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    let textColor: Color

    var body: some View {
        Text(text)
            .font(font(for: fontWeight, size: fontSize))
            .foregroundStyle(textColor)
    }

    private func font(for weight: Font.Weight, size: CGFloat) -> Font {
        if weight == .bold { return .bold(size) }
        if weight == .semibold { return .semibold(size) }
        if weight == .medium { return .medium(size) }
        if weight == .light { return .light(size) }
        return .regular(size)
    }
}
