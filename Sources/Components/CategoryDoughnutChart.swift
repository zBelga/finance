import SwiftUI

/// Doughnut chart for category breakdowns. Segments have a small gap between
/// them and the tapped segment "lifts" outward from the center, with haptic.
struct CategoryDoughnutChart: View {
    struct Slice: Identifiable {
        let id = UUID()
        let label: String
        let value: Double
        let color: Color
    }

    let slices: [Slice]
    var diameter: CGFloat = 180
    var thickness: CGFloat = 14

    @State private var selected: UUID?
    @State private var animatedEnd: CGFloat = 0

    private var total: Double { slices.reduce(0) { $0 + $1.value } }

    var body: some View {
        ZStack {
            ForEach(computedSlices()) { slice in
                DoughnutSegment(
                    startAngle: slice.start,
                    endAngle: min(slice.end, slice.start + (slice.end - slice.start) * animatedEnd)
                )
                .stroke(slice.color, style: StrokeStyle(lineWidth: thickness, lineCap: .butt))
                .rotationEffect(.degrees(-90))
                .scaleEffect(selected == slice.id ? 1.06 : 1.0)
                .shadow(color: slice.color.opacity(selected == slice.id ? 0.5 : 0), radius: 6)
                .animation(.spring(response: 0.35, dampingFraction: 0.7), value: selected)
                .onTapGesture {
                    Haptics.selection()
                    selected = (selected == slice.id) ? nil : slice.id
                }
            }

            if let selected, let slice = computedSlices().first(where: { $0.id == selected }) {
                VStack(spacing: 2) {
                    Text(slice.label).font(AurumFont.caption).foregroundStyle(AurumColor.inkTertiary)
                    Text(slice.value, format: .currency(code: "BRL"))
                        .font(AurumFont.numeric(15, weight: .semibold))
                        .foregroundStyle(AurumColor.inkPrimary)
                }
                .transition(.opacity.combined(with: .scale))
            }
        }
        .frame(width: diameter, height: diameter)
        .onAppear {
            withAnimation(.easeOut(duration: 0.9)) { animatedEnd = 1 }
        }
    }

    private struct ComputedSlice: Identifiable {
        let id: UUID
        let label: String
        let value: Double
        let color: Color
        let start: Angle
        let end: Angle
    }

    private func computedSlices() -> [ComputedSlice] {
        var result: [ComputedSlice] = []
        var cursor = 0.0
        let gap = 3.0 // degrees between segments
        for slice in slices {
            let fraction = total > 0 ? slice.value / total : 0
            let sweep = fraction * 360 - gap
            let start = cursor
            let end = cursor + max(sweep, 0)
            result.append(ComputedSlice(id: slice.id, label: slice.label, value: slice.value, color: slice.color, start: .degrees(start), end: .degrees(end)))
            cursor += fraction * 360
        }
        return result
    }
}

private struct DoughnutSegment: Shape {
    let startAngle: Angle
    let endAngle: Angle

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.width, rect.height) / 2
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        return path
    }
}
