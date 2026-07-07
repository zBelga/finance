import SwiftUI

/// The Dashboard's centerpiece: total net worth, animated count-up, a trend
/// badge, and a soft sparkline glowing at the bottom of the glass card.
struct NetWorthHeroCard: View {
    @State private var balanceHidden = false

    var body: some View {
        VStack(alignment: .leading, spacing: AurumSpacing.sm) {
            HStack {
                Text("Patrimônio total")
                    .font(AurumFont.subheadline)
                    .foregroundStyle(AurumColor.inkSecondary)
                Spacer()
                Button {
                    Haptics.light()
                    withAnimation { balanceHidden.toggle() }
                } label: {
                    Image(systemName: balanceHidden ? "eye.slash.fill" : "eye.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(AurumColor.inkTertiary)
                }
            }

            HStack(alignment: .firstTextBaseline, spacing: AurumSpacing.sm) {
                AnimatedNumberText(value: MockData.netWorth, hidden: balanceHidden)
                TrendBadge(percentage: MockData.netWorthChangePercent)
            }

            Spacer(minLength: AurumSpacing.md)

            CustomLineChart(data: MockData.cashFlowSeries, tint: AurumColor.gold, height: 70, showsTooltip: false)
                .opacity(balanceHidden ? 0.25 : 0.9)
        }
        .padding(AurumSpacing.lg)
        .frame(maxWidth: .infinity)
        .frame(height: 212)
        .aurumGlass(.hero, cornerRadius: AurumRadius.xl)
        .aurumTilt()
    }
}
