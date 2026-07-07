import SwiftUI

/// Small pill tag used for transaction categories, subscription renewal dates, etc.
struct CategoryBadge: View {
    let text: String
    var icon: String? = nil
    var color: Color = AurumColor.azure

    var body: some View {
        HStack(spacing: 4) {
            if let icon {
                Image(systemName: icon).font(.system(size: 10, weight: .semibold))
            }
            Text(text).font(AurumFont.caption)
        }
        .foregroundStyle(color)
        .padding(.horizontal, AurumSpacing.xs)
        .padding(.vertical, 4)
        .background(Capsule().fill(color.opacity(0.16)))
    }
}

/// A calm, line-art-flavored empty state used whenever a section has no data yet.
struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: AurumSpacing.md) {
            Image(systemName: icon)
                .font(.system(size: 34, weight: .light))
                .foregroundStyle(AurumColor.inkQuaternary)
                .padding(22)
                .background(Circle().fill(AurumColor.bgElevated2))

            VStack(spacing: 4) {
                Text(title).font(AurumFont.title3).foregroundStyle(AurumColor.inkPrimary)
                Text(message)
                    .font(AurumFont.callout)
                    .foregroundStyle(AurumColor.inkTertiary)
                    .multilineTextAlignment(.center)
            }

            if let actionTitle, let action {
                SecondaryButton(title: actionTitle, icon: "plus", action: action)
                    .frame(maxWidth: 220)
            }
        }
        .padding(AurumSpacing.xl)
        .frame(maxWidth: .infinity)
    }
}
