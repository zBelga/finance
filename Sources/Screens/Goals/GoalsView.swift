import SwiftUI

/// Placeholder screen (see docs/03-WIREFRAMES.md §3): grid layout and ring
/// component are final; goal creation flow is the next implementation phase.
struct GoalsView: View {
    @State private var appeared = false
    private let columns = [GridItem(.flexible(), spacing: AurumSpacing.cardGap), GridItem(.flexible(), spacing: AurumSpacing.cardGap)]

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottomTrailing) {
                AurumColor.bgBase.ignoresSafeArea()
                AurumMesh.calm(in: geo.size).ignoresSafeArea().blur(radius: 40)

                ScrollView {
                    VStack(alignment: .leading, spacing: AurumSpacing.lg) {
                        Text("Metas").font(AurumFont.title1).foregroundStyle(AurumColor.inkPrimary)
                            .padding(.top, AurumSpacing.md)

                        LazyVGrid(columns: columns, spacing: AurumSpacing.cardGap) {
                            ForEach(MockData.goals) { goal in
                                GlassCard {
                                    VStack(spacing: AurumSpacing.sm) {
                                        ProgressRing(progress: goal.progress, diameter: 70)
                                        Text(goal.name).font(AurumFont.headline).foregroundStyle(AurumColor.inkPrimary).lineLimit(1)
                                        Text(goal.current, format: .currency(code: "BRL").precision(.fractionLength(0)))
                                            .font(AurumFont.caption)
                                            .foregroundStyle(AurumColor.inkTertiary)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                        }

                        Color.clear.frame(height: AurumSpacing.xxxl)
                    }
                    .padding(.horizontal, AurumSpacing.screenMargin)
                }
                .aurumEntrance(delay: 0, appeared: appeared)

                FloatingActionButton { Haptics.medium() }
                    .padding(.trailing, AurumSpacing.screenMargin)
                    .padding(.bottom, 96)
            }
        }
        .onAppear { withAnimation { appeared = true } }
    }
}
