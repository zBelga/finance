import SwiftUI

struct DashboardHeader: View {
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: .now)
        switch hour {
        case 5..<12: return "Bom dia"
        case 12..<18: return "Boa tarde"
        default: return "Boa noite"
        }
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("\(greeting), Fabricio")
                    .font(AurumFont.footnote)
                    .foregroundStyle(AurumColor.inkTertiary)
                Text("Sua visão geral")
                    .font(AurumFont.title1)
                    .foregroundStyle(AurumColor.inkPrimary)
            }
            Spacer()
            Circle()
                .fill(AurumColor.bgElevated2)
                .frame(width: 40, height: 40)
                .overlay(
                    Text("F")
                        .font(AurumFont.headline)
                        .foregroundStyle(AurumColor.gold)
                )
                .aurumShadow(.resting)
        }
    }
}
