import SwiftUI

/// Placeholder screen (see docs/03-WIREFRAMES.md §5): the physical-proportion
/// card carousel is final; statement/detail view is the next phase.
struct CardsView: View {
    @State private var appeared = false
    @State private var selectedCard = 0

    var body: some View {
        GeometryReader { geo in
            ZStack {
                AurumColor.bgBase.ignoresSafeArea()
                AurumMesh.calm(in: geo.size).ignoresSafeArea().blur(radius: 40)

                VStack(alignment: .leading, spacing: AurumSpacing.lg) {
                    Text("Cartões").font(AurumFont.title1).foregroundStyle(AurumColor.inkPrimary)
                        .padding(.horizontal, AurumSpacing.screenMargin)
                        .padding(.top, AurumSpacing.md)

                    TabView(selection: $selectedCard) {
                        ForEach(Array(MockData.cards.enumerated()), id: \.element.id) { index, card in
                            CardVisual(card: card)
                                .padding(.horizontal, AurumSpacing.screenMargin)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .frame(height: 220)

                    GlassCard {
                        VStack(alignment: .leading, spacing: AurumSpacing.sm) {
                            Text("Fatura atual").font(AurumFont.subheadline).foregroundStyle(AurumColor.inkSecondary)
                            AnimatedNumberText(value: MockData.cards[selectedCard].used, font: AurumFont.numeric(26, weight: .bold))
                            AurumProgressBar(progress: MockData.cards[selectedCard].used / max(MockData.cards[selectedCard].limit, 1), tint: AurumColor.gold)
                            Text("Limite de \(MockData.cards[selectedCard].limit, format: .currency(code: "BRL"))")
                                .font(AurumFont.caption)
                                .foregroundStyle(AurumColor.inkTertiary)
                        }
                    }
                    .padding(.horizontal, AurumSpacing.screenMargin)

                    Spacer()
                }
                .aurumEntrance(delay: 0, appeared: appeared)
            }
        }
        .onAppear { withAnimation { appeared = true } }
    }
}

private struct CardVisual: View {
    let card: CardAccount

    var body: some View {
        VStack(alignment: .leading, spacing: AurumSpacing.lg) {
            HStack {
                Image(systemName: "wave.3.right").foregroundStyle(.white.opacity(0.7))
                Spacer()
                Text(card.bankName).font(AurumFont.headline).foregroundStyle(.white)
            }
            Spacer()
            Text("•••• •••• •••• \(card.last4)")
                .font(AurumFont.numeric(18, weight: .medium))
                .foregroundStyle(.white.opacity(0.9))
        }
        .padding(AurumSpacing.lg)
        .frame(maxWidth: .infinity)
        .frame(height: 190)
        .background(LinearGradient(colors: card.gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: AurumRadius.xl, style: .continuous))
        .aurumShadow(.raised)
        .aurumTilt()
    }
}
