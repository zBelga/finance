import SwiftUI

struct InvestmentsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AurumSpacing.md) {
            SectionHeader(title: "Investimentos")

            GlassCard {
                VStack(alignment: .leading, spacing: AurumSpacing.sm) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Total investido").font(AurumFont.subheadline).foregroundStyle(AurumColor.inkSecondary)
                            AnimatedNumberText(value: MockData.investmentsTotal, font: AurumFont.numeric(24, weight: .bold))
                        }
                        Spacer()
                        TrendBadge(percentage: MockData.investmentsChangePercent)
                    }
                    CustomLineChart(data: MockData.investmentSeries, tint: AurumColor.azure, height: 90, showsTooltip: false)
                }
            }
        }
    }
}
