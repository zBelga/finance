import SwiftUI

struct GoalsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AurumSpacing.md) {
            SectionHeader(title: "Objetivos")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AurumSpacing.cardGap) {
                    ForEach(MockData.goals) { goal in
                        GoalCard(goal: goal)
                    }
                    NewGoalCard()
                }
                .padding(.vertical, 2)
            }
        }
    }
}

private struct GoalCard: View {
    let goal: FinancialGoal

    var body: some View {
        GlassCard {
            VStack(spacing: AurumSpacing.sm) {
                ProgressRing(progress: goal.progress, diameter: 56)
                Text(goal.name)
                    .font(AurumFont.footnote.weight(.semibold))
                    .foregroundStyle(AurumColor.inkPrimary)
                    .lineLimit(1)
                Text("\(goal.current.formatted(.currency(code: "BRL").precision(.fractionLength(0)))) de \(goal.target.formatted(.currency(code: "BRL").precision(.fractionLength(0))))")
                    .font(AurumFont.caption)
                    .foregroundStyle(AurumColor.inkTertiary)
                    .lineLimit(1)
            }
        }
        .frame(width: 140)
    }
}

private struct NewGoalCard: View {
    var body: some View {
        Button {
            Haptics.light()
        } label: {
            VStack(spacing: AurumSpacing.xs) {
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(AurumColor.gold)
                Text("Nova meta")
                    .font(AurumFont.footnote)
                    .foregroundStyle(AurumColor.inkSecondary)
            }
            .frame(width: 140, height: 150)
            .background(
                RoundedRectangle(cornerRadius: AurumRadius.lg, style: .continuous)
                    .strokeBorder(AurumColor.inkQuaternary, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
            )
        }
        .buttonStyle(.aurumPressable)
    }
}

struct SectionHeader: View {
    let title: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(title).font(AurumFont.title2).foregroundStyle(AurumColor.inkPrimary)
            Spacer()
            if let actionTitle, let action {
                Button(action: action) {
                    Text(actionTitle).font(AurumFont.footnote).foregroundStyle(AurumColor.gold)
                }
            }
        }
    }
}
