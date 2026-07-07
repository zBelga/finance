import CoreGraphics

/// Aurum spacing scale (4pt grid). See docs/01-DESIGN-SYSTEM.md §3.
enum AurumSpacing {
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
    static let xxxl: CGFloat = 64

    /// Standard horizontal screen margin.
    static let screenMargin: CGFloat = 20
    /// Gap between cards within the same section.
    static let cardGap: CGFloat = 14
    /// Gap between major dashboard sections.
    static let sectionGap: CGFloat = 36
}

/// Aurum corner radius scale. See docs/01-DESIGN-SYSTEM.md §4.
enum AurumRadius {
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 20
    static let xl: CGFloat = 28
    static let pill: CGFloat = 999
}
