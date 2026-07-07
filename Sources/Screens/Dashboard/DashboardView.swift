import SwiftUI

/// The Aurum Dashboard: the app's "living" centerpiece. Every section enters
/// in a staggered cascade the first time the screen appears, the background
/// mesh gradient drifts slightly with scroll (parallax), and nothing is
/// static — numbers count up, charts trace in, cards breathe.
struct DashboardView: View {
    @State private var appeared = false
    @State private var scrollOffset: CGFloat = 0

    /// Order in which each section becomes visible. Kept centralized so the
    /// cascade timing can be tuned from a single place.
    private enum Stagger {
        static let header = 0.0
        static let hero = 0.08
        static let calendar = 0.16
        static let cashFlow = 0.24
        static let incomeExpense = 0.30
        static let goals = 0.36
        static let investments = 0.42
        static let category = 0.48
        static let cards = 0.54
        static let subscriptions = 0.60
    }

    var body: some View {
        GeometryReader { rootGeo in
            ZStack {
                AurumColor.bgBase.ignoresSafeArea()

                AurumMesh.wealth(in: rootGeo.size)
                    .offset(y: scrollOffset * 0.3)
                    .ignoresSafeArea()
                    .blur(radius: 40)

                ScrollView {
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: ScrollOffsetKey.self, value: proxy.frame(in: .named("dashboardScroll")).minY)
                    }
                    .frame(height: 0)

                    VStack(alignment: .leading, spacing: AurumSpacing.sectionGap) {
                        DashboardHeader()
                            .aurumEntrance(delay: Stagger.header, appeared: appeared)

                        NetWorthHeroCard()
                            .aurumEntrance(delay: Stagger.hero, appeared: appeared)

                        FinancialCalendarStrip(events: MockData.calendarStrip)
                            .aurumEntrance(delay: Stagger.calendar, appeared: appeared)

                        CashFlowSection()
                            .aurumEntrance(delay: Stagger.cashFlow, appeared: appeared)

                        IncomeExpenseRow()
                            .aurumEntrance(delay: Stagger.incomeExpense, appeared: appeared)

                        GoalsSection()
                            .aurumEntrance(delay: Stagger.goals, appeared: appeared)

                        InvestmentsSection()
                            .aurumEntrance(delay: Stagger.investments, appeared: appeared)

                        SpendingByCategorySection()
                            .aurumEntrance(delay: Stagger.category, appeared: appeared)

                        CardsSection()
                            .aurumEntrance(delay: Stagger.cards, appeared: appeared)

                        SubscriptionsSection()
                            .aurumEntrance(delay: Stagger.subscriptions, appeared: appeared)

                        // Breathing room so the floating tab bar never overlaps content.
                        Color.clear.frame(height: AurumSpacing.xxxl)
                    }
                    .padding(.horizontal, AurumSpacing.screenMargin)
                    .padding(.top, AurumSpacing.md)
                }
                .coordinateSpace(name: "dashboardScroll")
                .onPreferenceChange(ScrollOffsetKey.self) { scrollOffset = $0 }
                .refreshable {
                    Haptics.light()
                    try? await Task.sleep(nanoseconds: 600_000_000)
                }
            }
        }
        .onAppear {
            withAnimation { appeared = true }
        }
    }
}

private struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    DashboardView()
        .preferredColorScheme(.dark)
}
