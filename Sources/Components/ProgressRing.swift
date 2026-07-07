import SwiftUI

/// Circular progress indicator with a conic gold→emerald gradient, rounded cap,
/// and a center count-up label. Used for financial goals.
struct ProgressRing: View {
    let progress: Double // 0...1
    var lineWidth: CGFloat = 10
    var diameter: CGFloat = 64
    var showsPercentageLabel: Bool = true

    @State private var animatedProgress: Double = 0

    var body: some View {
        ZStack {
            Circle()
                .stroke(AurumColor.bgElevated3, lineWidth: lineWidth)

            Circle()
                .trim(from: 0, to: animatedProgress)
                .stroke(
                    AngularGradient(
                        colors: [AurumColor.gold, AurumColor.emerald],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .shadow(color: AurumColor.gold.opacity(animatedProgress >= 1 ? 0.6 : 0), radius: 8)

            if showsPercentageLabel {
                Text("\(Int(animatedProgress * 100))%")
                    .font(AurumFont.numeric(diameter * 0.22, weight: .semibold))
                    .foregroundStyle(AurumColor.inkPrimary)
                    .aurumTabularNumbers()
            }
        }
        .frame(width: diameter, height: diameter)
        .onAppear { animate() }
        .onChange(of: progress) { _, _ in animate() }
    }

    private func animate() {
        withAnimation(.easeInOut(duration: 0.8)) {
            animatedProgress = progress
        }
        if progress >= 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                Haptics.success()
            }
        }
    }
}

/// Thin linear progress bar used for per-category budgets, with a glow that
/// appears once the value crosses 90%.
struct AurumProgressBar: View {
    let progress: Double // 0...1
    var tint: Color = AurumColor.gold

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(AurumColor.bgElevated3)
                Capsule()
                    .fill(tint)
                    .frame(width: geo.size.width * min(max(progress, 0), 1))
                    .shadow(color: tint.opacity(progress > 0.9 ? 0.7 : 0), radius: 6)
            }
        }
        .frame(height: 6)
        .animation(.spring(response: 0.6, dampingFraction: 0.85), value: progress)
    }
}
