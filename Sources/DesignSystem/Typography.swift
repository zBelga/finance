import SwiftUI

/// Aurum typography tokens. See docs/01-DESIGN-SYSTEM.md §2.
enum AurumFont {
    static let display  = Font.system(size: 40, weight: .bold, design: .rounded)
    static let title1   = Font.system(size: 28, weight: .bold, design: .default)
    static let title2   = Font.system(size: 22, weight: .semibold, design: .default)
    static let title3   = Font.system(size: 18, weight: .semibold, design: .default)
    static let headline = Font.system(size: 16, weight: .semibold, design: .default)
    static let body     = Font.system(size: 16, weight: .regular, design: .default)
    static let callout  = Font.system(size: 15, weight: .regular, design: .default)
    static let subheadline = Font.system(size: 14, weight: .medium, design: .default)
    static let footnote = Font.system(size: 13, weight: .regular, design: .default)
    static let caption  = Font.system(size: 11, weight: .medium, design: .default)

    /// Numeric/monetary values always use rounded + tabular figures.
    static func numeric(_ size: CGFloat, weight: Font.Weight = .semibold) -> Font {
        .system(size: size, weight: weight, design: .rounded)
    }
}

extension View {
    /// Applies the Aurum caption style with letter-spacing, used for tags/timestamps.
    func aurumCaption() -> some View {
        self.font(AurumFont.caption)
            .tracking(0.4)
            .foregroundStyle(AurumColor.inkTertiary)
    }

    /// Ensures numeric text is tabular so amounts don't jitter horizontally while animating.
    func aurumTabularNumbers() -> some View {
        self.monospacedDigit()
    }
}
