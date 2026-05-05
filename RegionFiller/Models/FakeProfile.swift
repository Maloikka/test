import Foundation

/// «Липовый» профиль для подставновки в системную форму страны/региона iOS.
struct FakeProfile: Identifiable, Hashable {
    var id = UUID()

    var country: Country

    var firstName: String
    var lastName: String

    var addressLine1: String
    var addressLine2: String  // необязательно
    var city: String
    var region: String        // штат / иль / область
    var postalCode: String

    /// Локальная часть телефона, без кода страны (как iOS — отдельное поле «код+телефон»).
    var phoneAreaCode: String
    var phoneNumber: String

    var fullPhone: String {
        "+\(country.phoneCode) \(phoneAreaCode) \(phoneNumber)"
    }

    var fullName: String { "\(firstName) \(lastName)" }
}
