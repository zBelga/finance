import SwiftUI

/// Renders a currency value that counts smoothly from its previous value to the
/// new one — never "pops" into place. Used for every monetary figure in Aurum.
struct AnimatedNumberText: View {
    let value: Double
    var font: Font = AurumFont.display
    var color: Color = AurumColor.inkPrimary
    var currencyCode: String = "BRL"
    var hidden: Bool = false

    @State private var animatedValue: Double = 0

    var body: some View {
        Text(formatted(animatedValue))
            .font(font)
            .aurumTabularNumbers()
            .foregroundStyle(color)
            .contentTransition(.numericText())
            .blur(radius: hidden ? 14 : 0)
            .opacity(hidden ? 0.35 : 1)
            .animation(.easeOut(duration: 0.35), value: hidden)
            .onAppear {
                animate(to: value)
            }
            .onChange(of: value) { _, newValue in
                animate(to: newValue)
            }
    }

    private func animate(to newValue: Double) {
        withAnimation(.easeOut(duration: 0.9)) {
            animatedValue = newValue
        }
    }

    private func formatted(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
}

/// A small trend badge ("+12,4%") with an arrow and semantic color.
struct TrendBadge: View {
    let percentage: Double

    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: percentage >= 0 ? "arrow.up.right" : "arrow.down.right")
                .font(.system(size: 10, weight: .bold))
            Text("\(percentage >= 0 ? "+" : "")\(percentage, specifier: "%.1f")%")
                .font(AurumFont.caption)
        }
        .foregroundStyle(AurumColor.trendColor(for: percentage))
        .padding(.horizontal, AurumSpacing.xs)
        .padding(.vertical, 4)
        .background(
            Capsule().fill(AurumColor.trendColor(for: percentage).opacity(0.14))
        )
    }
}
