import SwiftUI

struct SpendingByCategorySection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AurumSpacing.md) {
            SectionHeader(title: "Gastos por categoria")

            GlassCard {
                HStack(spacing: AurumSpacing.lg) {
                    CategoryDoughnutChart(slices: MockData.categorySpending, diameter: 128, thickness: 16)

                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(MockData.categorySpending) { slice in
                            HStack(spacing: 6) {
                                Circle().fill(slice.color).frame(width: 6, height: 6)
                                Text(slice.label).font(AurumFont.caption).foregroundStyle(AurumColor.inkSecondary)
                                Spacer()
                                Text(slice.value, format: .currency(code: "BRL").precision(.fractionLength(0)))
                                    .font(AurumFont.caption.weight(.semibold))
                                    .foregroundStyle(AurumColor.inkPrimary)
                            }
                        }
                    }
                }
            }
        }
    }
}
