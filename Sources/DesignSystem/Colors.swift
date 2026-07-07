import SwiftUI

/// Aurum color tokens. See docs/01-DESIGN-SYSTEM.md §1 for rationale.
enum AurumColor {

    // MARK: Background scale (obsidian)
    static let bgBase       = Color(hex: 0x0A0A0C)
    static let bgElevated1  = Color(hex: 0x131317)
    static let bgElevated2  = Color(hex: 0x1B1B20)
    static let bgElevated3  = Color(hex: 0x24242B)

    // MARK: Ink (text) scale
    static let inkPrimary    = Color(hex: 0xF5F5F7).opacity(0.92)
    static let inkSecondary  = Color(hex: 0xF5F5F7).opacity(0.64)
    static let inkTertiary   = Color(hex: 0xF5F5F7).opacity(0.40)
    static let inkQuaternary = Color(hex: 0xF5F5F7).opacity(0.18)

    // MARK: Accents
    static let gold      = Color(hex: 0xD9B776)
    static let goldGlow  = Color(hex: 0xF0D9A8)
    static let emerald   = Color(hex: 0x3DDC91)
    static let coral     = Color(hex: 0xFF7A6E)
    static let azure     = Color(hex: 0x6FB8FF)
    static let violet    = Color(hex: 0xB79CFF)

    // MARK: Semantic aliases
    static let positive = emerald
    static let negative = coral
    static let income   = emerald
    static let expense  = coral
    static let investment = azure
    static let subscription = violet

    // MARK: Glass border / highlight
    static let glassBorder    = Color.white.opacity(0.10)
    static let glassHighlight = Color.white.opacity(0.14)

    /// Gradient used on the primary CTA and the wealth hero accents.
    static let goldGradient = LinearGradient(
        colors: [gold, goldGlow],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let emeraldGradient = LinearGradient(
        colors: [emerald.opacity(0.9), emerald.opacity(0.5)],
        startPoint: .top,
        endPoint: .bottom
    )

    static func trendColor(for value: Double) -> Color {
        value >= 0 ? positive : negative
    }
}

// MARK: - Mesh gradients (ambient background light)

enum AurumMesh {
    /// Warm, gold-anchored mesh used behind wealth-oriented screens (Dashboard).
    static func wealth(in size: CGSize) -> some View {
        ZStack {
            RadialGradient(
                colors: [AurumColor.gold.opacity(0.14), .clear],
                center: .topTrailing,
                startRadius: 10,
                endRadius: max(size.width, size.height) * 0.75
            )
            RadialGradient(
                colors: [AurumColor.azure.opacity(0.08), .clear],
                center: .bottomLeading,
                startRadius: 10,
                endRadius: max(size.width, size.height) * 0.7
            )
        }
    }

    /// Cooler, calmer mesh used for secondary/utility screens.
    static func calm(in size: CGSize) -> some View {
        ZStack {
            RadialGradient(
                colors: [AurumColor.azure.opacity(0.10), .clear],
                center: .bottomLeading,
                startRadius: 10,
                endRadius: max(size.width, size.height) * 0.75
            )
            RadialGradient(
                colors: [AurumColor.violet.opacity(0.08), .clear],
                center: .topTrailing,
                startRadius: 10,
                endRadius: max(size.width, size.height) * 0.7
            )
        }
    }

    /// Reserved for error / attention states.
    static func alert(in size: CGSize) -> some View {
        RadialGradient(
            colors: [AurumColor.coral.opacity(0.12), .clear],
            center: .top,
            startRadius: 10,
            endRadius: max(size.width, size.height) * 0.8
        )
    }
}

// MARK: - Hex initializer

extension Color {
    init(hex: UInt32, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}
