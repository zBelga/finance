import SwiftUI

/// Pill-shaped primary call to action. Gold gradient, gold-tinted shadow.
struct PrimaryButton: View {
    let title: String
    var icon: String? = nil
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: AurumSpacing.xs) {
                if let icon {
                    Image(systemName: icon).font(.system(size: 15, weight: .semibold))
                }
                Text(title).font(AurumFont.headline)
            }
            .foregroundStyle(AurumColor.bgBase)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AurumSpacing.sm + 2)
            .background(AurumColor.goldGradient, in: Capsule())
            .aurumShadow(.raised)
        }
        .buttonStyle(.aurumPressable)
    }
}

/// Secondary action — same shape, glass surface instead of gold fill.
struct SecondaryButton: View {
    let title: String
    var icon: String? = nil
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: AurumSpacing.xs) {
                if let icon {
                    Image(systemName: icon).font(.system(size: 15, weight: .semibold))
                }
                Text(title).font(AurumFont.headline)
            }
            .foregroundStyle(AurumColor.inkPrimary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AurumSpacing.sm + 2)
            .aurumGlass(.thin, cornerRadius: AurumRadius.pill)
        }
        .buttonStyle(.aurumPressable)
    }
}

/// A floating circular action button with a continuous, gentle "breathing" glow
/// and a long-press radial menu for quick creation actions.
struct FloatingActionButton: View {
    var systemImage: String = "plus"
    var action: () -> Void

    @State private var breathe = false

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(AurumColor.bgBase)
                .frame(width: 56, height: 56)
                .background(AurumColor.goldGradient, in: Circle())
                .aurumShadow(.floating)
                .scaleEffect(breathe ? 1.03 : 1.0)
        }
        .buttonStyle(.aurumPressable)
        .onAppear {
            withAnimation(.easeInOut(duration: 2.4).repeatForever(autoreverses: true)) {
                breathe = true
            }
        }
    }
}
