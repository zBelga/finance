import SwiftUI

/// Glass/material styles. See docs/01-DESIGN-SYSTEM.md §6.
enum AurumGlassStyle {
    case thin      // standard cards
    case regular   // sheets, modals
    case hero      // wealth hero card — includes internal glass reflection + gold glow
}

/// A reusable "liquid glass" background modifier: material + hairline border +
/// top highlight (where light would hit first) + physically-motivated shadow.
struct AurumGlassBackground: ViewModifier {
    var style: AurumGlassStyle
    var cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(material)

                    if style == .hero {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.07), .clear],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }

                    // Top highlight hairline — simulates where ambient light grazes the glass edge.
                    VStack {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [AurumColor.glassHighlight, AurumColor.glassBorder, .clear],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                lineWidth: 1
                            )
                    }
                }
            }
            .aurumShadow(style == .hero ? .floating : .resting)
    }

    private var material: Material {
        switch style {
        case .thin: return .ultraThinMaterial
        case .regular: return .thinMaterial
        case .hero: return .ultraThinMaterial
        }
    }
}

extension View {
    func aurumGlass(_ style: AurumGlassStyle = .thin, cornerRadius: CGFloat = AurumRadius.lg) -> some View {
        modifier(AurumGlassBackground(style: style, cornerRadius: cornerRadius))
    }
}

/// Diagonal shimmer used for loading skeletons, replacing generic spinners.
struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = -0.6

    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geo in
                    LinearGradient(
                        colors: [.clear, Color.white.opacity(0.16), .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geo.size.width * 0.6)
                    .offset(x: phase * geo.size.width * 2.2)
                    .blendMode(.plusLighter)
                }
                .clipped()
            }
            .onAppear {
                withAnimation(.linear(duration: 1.4).repeatForever(autoreverses: false)) {
                    phase = 0.6
                }
            }
    }
}

extension View {
    func aurumShimmer() -> some View { modifier(ShimmerModifier()) }
}
