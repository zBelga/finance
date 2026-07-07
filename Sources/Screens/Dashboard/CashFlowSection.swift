import SwiftUI

struct CashFlowSection: View {
    @State private var rangeSelection = 1

    var body: some View {
        VStack(alignment: .leading, spacing: AurumSpacing.md) {
            HStack {
                Text("Fluxo de caixa").font(AurumFont.title2).foregroundStyle(AurumColor.inkPrimary)
                Spacer()
            }

            SegmentedTabs(options: ["Semana", "Mês", "Ano"], selection: $rangeSelection)

            GlassCard {
                VStack(alignment: .leading, spacing: AurumSpacing.sm) {
                    HStack(spacing: AurumSpacing.md) {
                        LegendDot(color: AurumColor.emerald, label: "Entradas", value: MockData.income)
                        LegendDot(color: AurumColor.coral, label: "Saídas", value: MockData.expenses)
                        Spacer()
                    }
                    CustomLineChart(data: MockData.cashFlowSeries, tint: AurumColor.emerald, height: 130)
                }
            }
        }
    }
}

private struct LegendDot: View {
    let color: Color
    let label: String
    let value: Double

    var body: some View {
        HStack(spacing: 6) {
            Circle().fill(color).frame(width: 7, height: 7)
            VStack(alignment: .leading, spacing: 0) {
                Text(label).font(AurumFont.caption).foregroundStyle(AurumColor.inkTertiary)
                Text(value, format: .currency(code: "BRL"))
                    .font(AurumFont.numeric(14, weight: .semibold))
                    .foregroundStyle(AurumColor.inkPrimary)
            }
        }
    }
}
