import SwiftUI

/// Hand-rolled bar chart (not Swift Charts) so each bar can grow independently
/// with a staggered spring, matching the "cascade" motion language of Aurum.
/// Used for income-vs-expense comparisons.
struct CustomBarChart: View {
    struct Bar: Identifiable {
        let id = UUID()
        let label: String
        let value: Double
        let color: Color
        var isActive: Bool = false
    }

    let bars: [Bar]
    var height: CGFloat = 140

    @State private var grownBars: Set<UUID> = []

    private var maxValue: Double {
        max(bars.map(\.value).max() ?? 1, 1)
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: AurumSpacing.sm) {
            ForEach(bars) { bar in
                VStack(spacing: AurumSpacing.xxs) {
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(bar.color.opacity(bar.isActive ? 1 : 0.55))
                            .shadow(color: bar.color.opacity(bar.isActive ? 0.5 : 0), radius: 8, y: 2)
                            .frame(
                                height: grownBars.contains(bar.id)
                                    ? geo.size.height * CGFloat(bar.value / maxValue)
                                    : 0
                            )
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                    Text(bar.label)
                        .font(AurumFont.caption)
                        .foregroundStyle(AurumColor.inkTertiary)
                }
            }
        }
        .frame(height: height)
        .onAppear { animateIn() }
    }

    private func animateIn() {
        for (i, bar) in bars.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.04) {
                withAnimation(.spring(response: 0.55, dampingFraction: 0.75)) {
                    _ = grownBars.insert(bar.id)
                }
            }
        }
    }
}
