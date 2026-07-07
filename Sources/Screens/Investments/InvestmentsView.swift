import SwiftUI

/// Placeholder screen (see docs/03-WIREFRAMES.md §4): hero + chart are final;
/// position-level drill-down is the next implementation phase.
struct InvestmentsView: View {
    @State private var appeared = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                AurumColor.bgBase.ignoresSafeArea()
                AurumMesh.wealth(in: geo.size).ignoresSafeArea().blur(radius: 40)

                ScrollView {
                    VStack(alignment: .leading, spacing: AurumSpacing.lg) {
                        Text("Investimentos").font(AurumFont.title1).foregroundStyle(AurumColor.inkPrimary)
                            .padding(.top, AurumSpacing.md)

                        GlassCard(style: .hero, cornerRadius: AurumRadius.xl) {
                            VStack(alignment: .leading, spacing: AurumSpacing.sm) {
                                Text("Total investido").font(AurumFont.subheadline).foregroundStyle(AurumColor.inkSecondary)
                                HStack(alignment: .firstTextBaseline, spacing: AurumSpacing.sm) {
                                    AnimatedNumberText(value: MockData.investmentsTotal, font: AurumFont.numeric(32, weight: .bold))
                                    TrendBadge(percentage: MockData.investmentsChangePercent)
                                }
                                CustomLineChart(data: MockData.investmentSeries, tint: AurumColor.azure, height: 120)
                            }
                        }

                        SectionHeader(title: "Posições")

                        GlassCard {
                            VStack(spacing: AurumSpacing.sm) {
                                ForEach(Array(MockData.investmentPositions.enumerated()), id: \.element.id) { index, position in
                                    HStack {
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(position.name).font(AurumFont.headline).foregroundStyle(AurumColor.inkPrimary)
                                            Text(position.value, format: .currency(code: "BRL"))
                                                .font(AurumFont.caption)
                                                .foregroundStyle(AurumColor.inkTertiary)
                                        }
                                        Spacer()
                                        TrendBadge(percentage: position.changePercent)
                                    }
                                    if index < MockData.investmentPositions.count - 1 {
                                        Divider().overlay(AurumColor.inkQuaternary)
                                    }
                                }
                            }
                        }

                        Color.clear.frame(height: AurumSpacing.xxxl)
                    }
                    .padding(.horizontal, AurumSpacing.screenMargin)
                }
                .aurumEntrance(delay: 0, appeared: appeared)
            }
        }
        .onAppear { withAnimation { appeared = true } }
    }
}
