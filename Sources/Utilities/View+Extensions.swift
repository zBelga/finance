import SwiftUI

/// A press-responsive scale effect used across every tappable Aurum component,
/// so pressing anything in the app feels consistent: scale down + spring back.
struct PressableStyle: ButtonStyle {
    var scale: CGFloat = 0.96
    var haptic: Bool = true

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.7), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed && haptic { Haptics.light() }
            }
    }
}

extension ButtonStyle where Self == PressableStyle {
    static var aurumPressable: PressableStyle { PressableStyle() }
}

/// Subtle finger-driven 3D tilt applied to cards (max 4 degrees), returning to
/// rest with a spring when the drag ends. See docs/02 §4 "Tilt de card".
struct TiltOnDrag: ViewModifier {
    @State private var tilt: CGSize = .zero

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(Double(tilt.height) * 4),
                axis: (x: -1, y: 0, z: 0),
                perspective: 0.6
            )
            .rotation3DEffect(
                .degrees(Double(tilt.width) * 4),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.6
            )
            .gesture(
                DragGesture(minimumDistance: 2)
                    .onChanged { value in
                        let w = max(-1, min(1, value.translation.width / 80))
                        let h = max(-1, min(1, value.translation.height / 80))
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                            tilt = CGSize(width: w, height: h)
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.65)) {
                            tilt = .zero
                        }
                    }
            )
    }
}

extension View {
    func aurumTilt() -> some View { modifier(TiltOnDrag()) }

    /// Staggered entrance used across the Dashboard: fade + slide-up, spring physics.
    func aurumEntrance(delay: Double, appeared: Bool) -> some View {
        self
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 16)
            .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(delay), value: appeared)
    }
}
