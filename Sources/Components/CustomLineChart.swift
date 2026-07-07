import SwiftUI
import Charts

struct ChartPoint: Identifiable, Equatable {
    let id = UUID()
    let label: String
    let value: Double
}

/// A signature Aurum line chart: smooth catmull-rom curve, soft gradient fill,
/// a pulsing glow on the most recent point, and a floating tooltip on drag.
/// This intentionally does not look like a default chart-library line chart.
struct CustomLineChart: View {
    let data: [ChartPoint]
    var tint: Color = AurumColor.gold
    var height: CGFloat = 160
    var showsTooltip: Bool = true

    @State private var selectedIndex: Int? = nil
    @State private var pulse = false

    var body: some View {
        Chart {
            ForEach(data) { point in
                AreaMark(
                    x: .value("Label", point.label),
                    y: .value("Value", point.value)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(
                    LinearGradient(
                        colors: [tint.opacity(0.35), tint.opacity(0.0)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

                LineMark(
                    x: .value("Label", point.label),
                    y: .value("Value", point.value)
                )
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                .foregroundStyle(tint)

                if let selectedIndex, data.indices.contains(selectedIndex), data[selectedIndex].id == point.id {
                    PointMark(
                        x: .value("Label", point.label),
                        y: .value("Value", point.value)
                    )
                    .foregroundStyle(AurumColor.inkPrimary)
                    .symbolSize(60)
                }
            }

            if let last = data.last {
                PointMark(
                    x: .value("Label", last.label),
                    y: .value("Value", last.value)
                )
                .foregroundStyle(tint)
                .symbolSize(pulse ? 130 : 70)
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartLegend(.hidden)
        .chartOverlay { proxy in
            GeometryReader { geo in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                guard showsTooltip else { return }
                                let x = value.location.x
                                if let label: String = proxy.value(atX: x) {
                                    if let idx = data.firstIndex(where: { $0.label == label }) {
                                        if idx != selectedIndex { Haptics.selection() }
                                        selectedIndex = idx
                                    }
                                }
                            }
                            .onEnded { _ in
                                withAnimation(.easeOut(duration: 0.2)) { selectedIndex = nil }
                            }
                    )

                if let selectedIndex, data.indices.contains(selectedIndex) {
                    let point = data[selectedIndex]
                    let plotRect = geo[proxy.plotAreaFrame]
                    if let x = proxy.position(forX: point.label) {
                        ChartTooltip(text: point.label, value: point.value, tint: tint)
                            .position(x: plotRect.minX + x, y: max(24, plotRect.minY))
                    }
                }
            }
        }
        .frame(height: height)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                pulse = true
            }
        }
    }
}

private struct ChartTooltip: View {
    let text: String
    let value: Double
    let tint: Color

    var body: some View {
        VStack(spacing: 2) {
            Text(text).font(AurumFont.caption).foregroundStyle(AurumColor.inkTertiary)
            Text(value, format: .currency(code: "BRL"))
                .font(AurumFont.numeric(14, weight: .semibold))
                .foregroundStyle(AurumColor.inkPrimary)
        }
        .padding(.horizontal, AurumSpacing.sm)
        .padding(.vertical, AurumSpacing.xxs)
        .aurumGlass(.regular, cornerRadius: AurumRadius.sm)
        .fixedSize()
    }
}
