import SwiftUI

enum AurumTab: Int, CaseIterable, Identifiable {
    case dashboard, transactions, goals, investments, cards
    var id: Int { rawValue }

    var title: String {
        switch self {
        case .dashboard: "Início"
        case .transactions: "Transações"
        case .goals: "Metas"
        case .investments: "Investir"
        case .cards: "Cartões"
        }
    }

    var icon: String {
        switch self {
        case .dashboard: "square.grid.2x2.fill"
        case .transactions: "list.bullet.rectangle.fill"
        case .goals: "target"
        case .investments: "chart.line.uptrend.xyaxis"
        case .cards: "creditcard.fill"
        }
    }
}

/// Replaces the system TabView chrome with a floating glass bar, anchored
/// above the safe area, with a sliding selection indicator and a small
/// "breathing" bounce on the icon that becomes active.
struct FloatingTabBar: View {
    @Binding var selection: AurumTab
    @Namespace private var namespace

    var body: some View {
        HStack(spacing: 0) {
            ForEach(AurumTab.allCases) { tab in
                Button {
                    if selection != tab {
                        Haptics.selection()
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                            selection = tab
                        }
                    }
                } label: {
                    VStack(spacing: 3) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 19, weight: .semibold))
                            .symbolEffect(.bounce, value: selection == tab)
                        Text(tab.title)
                            .font(.system(size: 10, weight: .medium))
                    }
                    .foregroundStyle(selection == tab ? AurumColor.gold : AurumColor.inkTertiary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background {
                        if selection == tab {
                            RoundedRectangle(cornerRadius: AurumRadius.md, style: .continuous)
                                .fill(AurumColor.gold.opacity(0.12))
                                .matchedGeometryEffect(id: "tabBarIndicator", in: namespace)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(6)
        .aurumGlass(.regular, cornerRadius: AurumRadius.xl)
        .padding(.horizontal, AurumSpacing.md)
    }
}
