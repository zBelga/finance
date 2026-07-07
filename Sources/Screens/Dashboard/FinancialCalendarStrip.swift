import SwiftUI

/// Horizontal strip of upcoming days with a small dot marking days that have
/// a financial event (bill due, expected income). Today glows gold.
struct FinancialCalendarStrip: View {
    let events: [CalendarEvent]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AurumSpacing.xs) {
                ForEach(events) { event in
                    VStack(spacing: 6) {
                        Text("\(event.day)")
                            .font(AurumFont.numeric(15, weight: event.isToday ? .bold : .medium))
                            .foregroundStyle(event.isToday ? AurumColor.bgBase : AurumColor.inkPrimary)

                        Circle()
                            .fill(event.hasEvent ? AurumColor.gold : .clear)
                            .frame(width: 4, height: 4)
                    }
                    .frame(width: 42, height: 54)
                    .background {
                        if event.isToday {
                            RoundedRectangle(cornerRadius: AurumRadius.md, style: .continuous)
                                .fill(AurumColor.goldGradient)
                                .aurumShadow(.resting)
                        } else {
                            RoundedRectangle(cornerRadius: AurumRadius.md, style: .continuous)
                                .fill(AurumColor.bgElevated2)
                        }
                    }
                }
            }
            .padding(.vertical, 2)
        }
    }
}
