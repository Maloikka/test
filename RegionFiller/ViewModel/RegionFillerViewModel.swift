import Foundation
import SwiftUI

@MainActor
final class RegionFillerViewModel: ObservableObject {
    @Published var country: Country = .usa {
        didSet { regenerate() }
    }
    @Published var profile: FakeProfile = ProfileGenerator.make(for: .usa)

    /// Выбран способ оплаты «Нет» — как на референсе из задания.
    @Published var paymentMethod: PaymentMethod = .none

    func regenerate() {
        profile = ProfileGenerator.make(for: country)
    }
}

enum PaymentMethod: String, CaseIterable, Identifiable {
    case card = "Кредитная или дебетовая карта"
    case paypal = "PayPal"
    case none = "Нет"

    var id: String { rawValue }

    var subtitle: String? {
        switch self {
        case .card: return "Visa, MasterCard, Discover, American Express"
        default: return nil
        }
    }
}
