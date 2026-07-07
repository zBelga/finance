import SwiftUI

struct CardsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AurumSpacing.md) {
            SectionHeader(title: "Cartões")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AurumSpacing.cardGap) {
                    ForEach(MockData.cards) { card in
                        CardTile(card: card)
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }
}

private struct CardTile: View {
    let card: CardAccount

    private var usageFraction: Double {
        card.limit > 0 ? min(card.used / card.limit, 1) : 0
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AurumSpacing.md) {
            HStack {
                Image(systemName: "wave.3.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.7))
                Spacer()
                Text("•••• \(card.last4)")
                    .font(AurumFont.numeric(13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.85))
            }
            Spacer()
            VStack(alignment: .leading, spacing: 6) {
                Text(card.bankName)
                    .font(AurumFont.footnote.weight(.semibold))
                    .foregroundStyle(.white)
                AurumProgressBar(progress: usageFraction, tint: .white.opacity(0.85))
                Text("\(card.used.formatted(.currency(code: "BRL").precision(.fractionLength(0)))) de \(card.limit.formatted(.currency(code: "BRL").precision(.fractionLength(0))))")
                    .font(AurumFont.caption)
                    .foregroundStyle(.white.opacity(0.65))
            }
        }
        .padding(AurumSpacing.md)
        .frame(width: 220, height: 132)
        .background(
            LinearGradient(colors: card.gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: AurumRadius.lg, style: .continuous))
        .aurumShadow(.raised)
        .aurumTilt()
    }
}
