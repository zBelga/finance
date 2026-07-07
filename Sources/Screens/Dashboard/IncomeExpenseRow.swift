import SwiftUI

/// Two side-by-side glass cards summarizing income and expenses for the period.
struct IncomeExpenseRow: View {
    var body: some View {
        HStack(spacing: AurumSpacing.cardGap) {
            SummaryTile(
                title: "Receitas",
                value: MockData.income,
                changePercent: MockData.incomeChangePercent,
                icon: "arrow.down.left",
                tint: AurumColor.emerald
            )
            SummaryTile(
                title: "Despesas",
                value: MockData.expenses,
                changePercent: MockData.expensesChangePercent,
                icon: "arrow.up.right",
                tint: AurumColor.coral
            )
        }
    }
}

private struct SummaryTile: View {
    let title: String
    let value: Double
    let changePercent: Double
    let icon: String
    let tint: Color

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: AurumSpacing.xs) {
                HStack {
                    Text(title).font(AurumFont.subheadline).foregroundStyle(AurumColor.inkSecondary)
                    Spacer()
                    Image(systemName: icon)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(tint)
                        .padding(5)
                        .background(Circle().fill(tint.opacity(0.14)))
                }
                AnimatedNumberText(value: value, font: AurumFont.numeric(22, weight: .bold), color: AurumColor.inkPrimary)
                TrendBadge(percentage: changePercent)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
