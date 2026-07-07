import SwiftUI

/// A two-layer shadow (ambient + key light), matching how real light behaves.
/// See docs/01-DESIGN-SYSTEM.md §5.
struct AurumShadow {
    let ambientColor: Color
    let ambientRadius: CGFloat
    let ambientY: CGFloat
    let keyColor: Color
    let keyRadius: CGFloat
    let keyY: CGFloat

    static let resting = AurumShadow(
        ambientColor: .black.opacity(0.18), ambientRadius: 20, ambientY: 8,
        keyColor: .black.opacity(0.08), keyRadius: 2, keyY: 1
    )

    static let raised = AurumShadow(
        ambientColor: .black.opacity(0.28), ambientRadius: 32, ambientY: 16,
        keyColor: .black.opacity(0.12), keyRadius: 4, keyY: 2
    )

    static let floating = AurumShadow(
        ambientColor: .black.opacity(0.36), ambientRadius: 48, ambientY: 24,
        keyColor: AurumColor.gold.opacity(0.10), keyRadius: 16, keyY: 0
    )
}

extension View {
    /// Applies a two-layer Aurum shadow.
    func aurumShadow(_ style: AurumShadow) -> some View {
        self
            .shadow(color: style.ambientColor, radius: style.ambientRadius, x: 0, y: style.ambientY)
            .shadow(color: style.keyColor, radius: style.keyRadius, x: 0, y: style.keyY)
    }
}
