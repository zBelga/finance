import SwiftUI

/// A glass pill segmented control where the selection indicator slides via
/// matchedGeometryEffect instead of cross-fading — feels like one physical
/// piece of glass moving, not different views swapping.
struct SegmentedTabs: View {
    let options: [String]
    @Binding var selection: Int
    @Namespace private var namespace

    var body: some View {
        HStack(spacing: 4) {
            ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                Text(option)
                    .font(index == selection ? AurumFont.subheadline.weight(.semibold) : AurumFont.subheadline)
                    .foregroundStyle(index == selection ? AurumColor.inkPrimary : AurumColor.inkTertiary)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background {
                        if index == selection {
                            Capsule()
                                .fill(AurumColor.bgElevated3)
                                .matchedGeometryEffect(id: "tabIndicator", in: namespace)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        Haptics.selection()
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                            selection = index
                        }
                    }
            }
        }
        .padding(4)
        .aurumGlass(.thin, cornerRadius: AurumRadius.pill)
    }
}
