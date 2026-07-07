import SwiftUI

/// Placeholder screen (next implementation phase per docs/03-WIREFRAMES.md §2):
/// the structure, grouping and row styling are final; real pagination and
/// filtering will be wired up once persistence exists.
struct TransactionsView: View {
    @State private var categoryFilter = 0
    @State private var appeared = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                AurumColor.bgBase.ignoresSafeArea()
                AurumMesh.calm(in: geo.size).ignoresSafeArea().blur(radius: 40)

                ScrollView {
                    VStack(alignment: .leading, spacing: AurumSpacing.lg) {
                        Text("Transações").font(AurumFont.title1).foregroundStyle(AurumColor.inkPrimary)
                            .padding(.top, AurumSpacing.md)

                        SegmentedTabs(options: ["Todas", "Receitas", "Despesas"], selection: $categoryFilter)

                        if MockData.transactions.isEmpty {
                            EmptyStateView(
                                icon: "list.bullet.rectangle",
                                title: "Nada por aqui ainda",
                                message: "Suas transações aparecerão aqui assim que você conectar uma conta ou adicionar um lançamento.",
                                actionTitle: "Adicionar lançamento",
                                action: { Haptics.light() }
                            )
                            .padding(.top, AurumSpacing.xxl)
                        } else {
                            GlassCard {
                                VStack(spacing: AurumSpacing.sm) {
                                    ForEach(Array(MockData.transactions.enumerated()), id: \.element.id) { index, tx in
                                        TransactionRow(transaction: tx)
                                        if index < MockData.transactions.count - 1 {
                                            Divider().overlay(AurumColor.inkQuaternary)
                                        }
                                    }
                                }
                            }
                        }

                        Color.clear.frame(height: AurumSpacing.xxxl)
                    }
                    .padding(.horizontal, AurumSpacing.screenMargin)
                }
                .aurumEntrance(delay: 0, appeared: appeared)
            }
        }
        .onAppear { withAnimation { appeared = true } }
    }
}

private struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: AurumSpacing.sm) {
            Image(systemName: transaction.icon)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(transaction.color)
                .frame(width: 36, height: 36)
                .background(Circle().fill(transaction.color.opacity(0.14)))

            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.merchant).font(AurumFont.headline).foregroundStyle(AurumColor.inkPrimary)
                CategoryBadge(text: transaction.category, color: transaction.color)
            }

            Spacer()

            Text(transaction.amount, format: .currency(code: "BRL"))
                .font(AurumFont.numeric(15, weight: .semibold))
                .foregroundStyle(transaction.amount >= 0 ? AurumColor.positive : AurumColor.inkPrimary)
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .contextMenu {
            // Long-press context menu (docs/02 §3 "Navegação" and §5 "Microinterações").
            // Swipe-to-delete/categorize will be reinstated once this list moves into
            // a native `List` in the persistence-backed implementation.
            Button { Haptics.selection() } label: { Label("Categorizar", systemImage: "tag") }
            Button(role: .destructive) { Haptics.warning() } label: { Label("Excluir", systemImage: "trash") }
        }
    }
}
