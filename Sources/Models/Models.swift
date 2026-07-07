import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    let merchant: String
    let category: String
    let icon: String
    let color: Color
    let amount: Double // negative = expense, positive = income
    let date: Date
}

struct FinancialGoal: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let current: Double
    let target: Double
    var progress: Double { target > 0 ? min(current / target, 1) : 0 }
}

struct InvestmentPosition: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
    let changePercent: Double
}

struct CardAccount: Identifiable {
    let id = UUID()
    let bankName: String
    let last4: String
    let gradient: [Color]
    let limit: Double
    let used: Double
}

struct Subscription: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    let monthlyAmount: Double
    let renewsInDays: Int
}

struct CalendarEvent: Identifiable {
    let id = UUID()
    let day: Int
    let weekday: String
    let hasEvent: Bool
    let isToday: Bool
}
