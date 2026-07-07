import SwiftUI

/// App shell: a NavigationStack per tab, with a floating glass tab bar
/// overlaid at the bottom instead of the system TabView chrome.
struct RootView: View {
    @State private var selection: AurumTab = .dashboard

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selection {
                case .dashboard:
                    NavigationStack { DashboardView() }
                case .transactions:
                    NavigationStack { TransactionsView() }
                case .goals:
                    NavigationStack { GoalsView() }
                case .investments:
                    NavigationStack { InvestmentsView() }
                case .cards:
                    NavigationStack { CardsView() }
                }
            }
            .transition(.opacity.combined(with: .scale(scale: 0.98)))
            .id(selection)

            FloatingTabBar(selection: $selection)
                .padding(.bottom, 6)
        }
        .preferredColorScheme(.dark)
        .animation(.easeInOut(duration: 0.2), value: selection)
    }
}

#Preview {
    RootView()
}
