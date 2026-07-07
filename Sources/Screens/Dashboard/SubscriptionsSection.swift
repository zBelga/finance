import SwiftUI

struct SubscriptionsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AurumSpacing.md) {
            SectionHeader(title: "Assinaturas", actionTitle: "Ver todas") {}

            GlassCard {
                VStack(spacing: AurumSpacing.sm) {
                    ForEach(Array(MockData.subscriptions.prefix(3).enumerated()), id: \.element.id) { index, sub in
                        SubscriptionRow(subscription: sub)
                        if index < min(MockData.subscriptions.count, 3) - 1 {
                            Divider().overlay(AurumColor.inkQuaternary)
                        }
                    }
                }
            }
        }
    }
}

private struct SubscriptionRow: View {
    let subscription: Subscription

    var body: some View {
        HStack(spacing: AurumSpacing.sm) {
            Image(systemName: subscription.icon)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(subscription.color)
                .frame(width: 34, height: 34)
                .background(Circle().fill(subscription.color.opacity(0.14)))

            VStack(alignment: .leading, spacing: 2) {
                Text(subscription.name).font(AurumFont.headline).foregroundStyle(AurumColor.inkPrimary)
                Text("Renova em \(subscription.renewsInDays)d").font(AurumFont.caption).foregroundStyle(AurumColor.inkTertiary)
            }

            Spacer()

            Text(subscription.monthlyAmount, format: .currency(code: "BRL"))
                .font(AurumFont.numeric(15, weight: .semibold))
                .foregroundStyle(AurumColor.inkPrimary)
        }
        .padding(.vertical, 4)
    }
}
