import SwiftUI

/// The base surface used almost everywhere in Aurum: a "sheet of frosted glass"
/// floating a few millimeters above the mesh-gradient background.
struct GlassCard<Content: View>: View {
    var style: AurumGlassStyle = .thin
    var cornerRadius: CGFloat = AurumRadius.lg
    var padding: CGFloat = AurumSpacing.md
    var tiltEnabled: Bool = true
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .padding(padding)
            .aurumGlass(style, cornerRadius: cornerRadius)
            .modifier(tiltEnabled ? AnyViewModifier(TiltOnDrag()) : AnyViewModifier(EmptyModifier()))
    }
}

/// Type-erased modifier so GlassCard can conditionally apply the tilt gesture
/// without duplicating the whole view hierarchy.
struct AnyViewModifier: ViewModifier {
    private let _body: (Content) -> AnyView
    init<M: ViewModifier>(_ modifier: M) {
        _body = { content in AnyView(content.modifier(modifier)) }
    }
    func body(content: Content) -> some View { _body(content) }
}
