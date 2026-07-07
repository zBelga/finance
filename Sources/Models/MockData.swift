import SwiftUI

/// Demonstration data so the Dashboard renders a fully composed screen
/// without needing a persistence layer yet.
enum MockData {
    static let netWorth: Double = 184_320.55
    static let netWorthChangePercent: Double = 4.8

    static let cashFlowSeries: [ChartPoint] = [
        .init(label: "Jan", value: 6200),
        .init(label: "Fev", value: 7100),
        .init(label: "Mar", value: 6800),
        .init(label: "Abr", value: 8300),
        .init(label: "Mai", value: 7950),
        .init(label: "Jun", value: 9100),
        .init(label: "Jul", value: 9800)
    ]

    static let income: Double = 9_800
    static let incomeChangePercent: Double = 6.2
    static let expenses: Double = 5_140
    static let expensesChangePercent: Double = -3.1

    static let incomeExpenseBars: [CustomBarChart.Bar] = [
        .init(label: "Abr", value: 8300, color: AurumColor.emerald),
        .init(label: "Mai", value: 7950, color: AurumColor.emerald),
        .init(label: "Jun", value: 9100, color: AurumColor.emerald),
        .init(label: "Jul", value: 9800, color: AurumColor.gold, isActive: true)
    ]

    static let goals: [FinancialGoal] = [
        .init(name: "Viagem Japão", icon: "airplane", current: 9200, target: 18000),
        .init(name: "Reserva emergência", icon: "shield.fill", current: 24000, target: 24000),
        .init(name: "Novo MacBook", icon: "laptopcomputer", current: 4300, target: 14000)
    ]

    static let investmentsTotal: Double = 62_450.30
    static let investmentsChangePercent: Double = 2.3
    static let investmentSeries: [ChartPoint] = [
        .init(label: "S1", value: 58000),
        .init(label: "S2", value: 59200),
        .init(label: "S3", value: 58700),
        .init(label: "S4", value: 60500),
        .init(label: "S5", value: 61800),
        .init(label: "S6", value: 62450)
    ]

    static let investmentPositions: [InvestmentPosition] = [
        .init(name: "Tesouro Selic 2029", value: 24_300, changePercent: 1.1),
        .init(name: "ETF IVVB11", value: 18_900, changePercent: 4.6),
        .init(name: "Ações BR (carteira)", value: 12_450, changePercent: -1.8),
        .init(name: "Reserva internacional", value: 6_800, changePercent: 0.6)
    ]

    static let cards: [CardAccount] = [
        .init(bankName: "Aurum Black", last4: "4821", gradient: [Color(hex: 0x2C2C34), Color(hex: 0x111114)], limit: 12000, used: 4230),
        .init(bankName: "Aurum Travel", last4: "7790", gradient: [AurumColor.azure.opacity(0.9), AurumColor.violet.opacity(0.9)], limit: 8000, used: 1120)
    ]

    static let subscriptions: [Subscription] = [
        .init(name: "iCloud+", icon: "icloud.fill", color: AurumColor.azure, monthlyAmount: 34.90, renewsInDays: 6),
        .init(name: "Spotify", icon: "music.note", color: AurumColor.emerald, monthlyAmount: 21.90, renewsInDays: 12),
        .init(name: "Streaming Plus", icon: "play.tv.fill", color: AurumColor.violet, monthlyAmount: 44.90, renewsInDays: 21)
    ]

    static let categorySpending: [CategoryDoughnutChart.Slice] = [
        .init(label: "Moradia", value: 2100, color: AurumColor.gold),
        .init(label: "Alimentação", value: 1180, color: AurumColor.emerald),
        .init(label: "Transporte", value: 620, color: AurumColor.azure),
        .init(label: "Lazer", value: 740, color: AurumColor.violet),
        .init(label: "Outros", value: 500, color: AurumColor.coral)
    ]

    static let transactions: [Transaction] = [
        .init(merchant: "Supermercado Pão de Ouro", category: "Alimentação", icon: "cart.fill", color: AurumColor.emerald, amount: -284.30, date: .now),
        .init(merchant: "Salário", category: "Receita", icon: "arrow.down.circle.fill", color: AurumColor.emerald, amount: 9800, date: .now.addingTimeInterval(-86400)),
        .init(merchant: "Uber", category: "Transporte", icon: "car.fill", color: AurumColor.azure, amount: -38.50, date: .now.addingTimeInterval(-86400 * 2))
    ]

    static let calendarStrip: [CalendarEvent] = (1...14).map { day in
        .init(day: day, weekday: "", hasEvent: [3, 6, 10, 12].contains(day), isToday: day == 6)
    }
}
