import SwiftUI

struct SuccessView: View {
    @EnvironmentObject private var budgetViewModel: BudgetViewModel

    private let confettiColors: [Color] = [.accent, .secondaryGreen, .orange, .cyan, .pink, .yellow]

    var body: some View {
        VStack(spacing: 0) {
            confirmationHeader
                .padding(.top, 26)

            transactionDetails
                .padding(.top, 48)

            Spacer(minLength: 32)

            actionButtons
                .padding(.bottom, 20)
        }
        .padding(.horizontal, 18)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }

    private var confirmationHeader: some View {
        VStack(spacing: 16) {
            ZStack {
                ForEach(0..<26, id: \.self) { index in
                    let angle = Double(index) * 2 * .pi / 26
                    Capsule()
                        .fill(confettiColors[index % confettiColors.count])
                        .frame(width: 4, height: 8)
                        .rotationEffect(.degrees(Double(index * 37 % 180)))
                        .offset(x: cos(angle) * 56, y: sin(angle) * 48)
                }

                Image(systemName: "checkmark")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 84, height: 84)
                    .background {
                        Circle()
                            .fill(LinearGradient(colors: [.green, .secondaryGreen], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                    .shadow(color: .secondaryGreen.opacity(0.25), radius: 8, y: 4)
            }
            .frame(width: 136, height: 122)

            TextComponent(text: "Budget Item Added", fontSize: 20, fontWeight: .bold, textColor: .secondaryGreen)
            TextComponent(text: "Budget item has been added successfully", fontSize: 14, fontWeight: .regular, textColor: .gray)
                .multilineTextAlignment(.center)
        }
    }

    private var transactionDetails: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.bottom, 18)

            detailRow(title: "Budget Item Name", value: budgetViewModel.itemName, titleColor: .gray)
            detailRow(title: "Amount", value: "\(currencyLabel) \(budgetViewModel.allocation)", titleColor: .black, valueColor: .green)
                .padding(.top, 14)
            detailRow(title: "Date", value: budgetViewModel.lastAddedAt.formatted(date: .complete, time: .omitted), titleColor: .gray)
                .padding(.top, 14)
        }
    }

    private var currencyLabel: String {
        budgetViewModel.currency == .kes ? "Ksh" : "USD"
    }

    private func detailRow(title: String, value: String, titleColor: Color, valueColor: Color = .black) -> some View {
        HStack(alignment: .firstTextBaseline) {
            TextComponent(text: title, fontSize: 14, fontWeight: title == "Amount" ? .semibold : .regular, textColor: titleColor)
            Spacer(minLength: 16)
            TextComponent(text: value, fontSize: 14, fontWeight: .medium, textColor: valueColor)
                .multilineTextAlignment(.trailing)
        }
    }

    private var actionButtons: some View {
        VStack(spacing: 12) {
            Button {
                budgetViewModel.clearForm()
                budgetViewModel.showSuccess = false
                budgetViewModel.selectedTab = .home
            } label: {
                TextComponent(text: "Go back to Home", fontSize: 14, fontWeight: .medium, textColor: .white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 46)
                    .background(Color.secondaryGreen, in: RoundedRectangle(cornerRadius: 8))
            }
            .buttonStyle(.plain)

            Button {} label: {
                TextComponent(text: "Rate your Experience", fontSize: 14, fontWeight: .medium, textColor: .secondaryGreen)
                    .frame(maxWidth: .infinity)
                    .frame(height: 46)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.65), lineWidth: 1)
                    }
            }
            .buttonStyle(.plain)
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView().environmentObject(BudgetViewModel())
    }
}
