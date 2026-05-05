import Foundation

/// Генератор реалистичных «липовых» профилей под выбранную страну.
/// Все компоненты адреса (город/штат/индекс) выбираются согласованно,
/// чтобы получившиеся данные не противоречили друг другу.
enum ProfileGenerator {

    static func make(for country: Country) -> FakeProfile {
        switch country {
        case .usa:        return makeUSA()
        case .india:      return makeIndia()
        case .turkey:     return makeTurkey()
        case .kazakhstan: return makeKazakhstan()
        }
    }

    // MARK: - USA

    private static func makeUSA() -> FakeProfile {
        let firstName = CountryData.usaFirstNames.randomElement()!
        let lastName  = CountryData.usaLastNames.randomElement()!
        let cityInfo  = CountryData.usaCities.randomElement()!
        let street    = CountryData.usaStreets.randomElement()!
        let houseNo   = Int.random(in: 10...9999)

        let areaCode  = CountryData.usaAreaCodes.randomElement()!
        let phoneLocal = String(format: "%03d-%04d", Int.random(in: 200...999), Int.random(in: 0...9999))

        return FakeProfile(
            country: .usa,
            firstName: firstName,
            lastName: lastName,
            addressLine1: "\(houseNo) \(street)",
            addressLine2: "",
            city: cityInfo.city,
            region: cityInfo.stateName,
            postalCode: cityInfo.zips.randomElement()!,
            phoneAreaCode: areaCode,
            phoneNumber: phoneLocal
        )
    }

    // MARK: - India

    private static func makeIndia() -> FakeProfile {
        let firstName = CountryData.indiaFirstNames.randomElement()!
        let lastName  = CountryData.indiaLastNames.randomElement()!
        let cityInfo  = CountryData.indiaCities.randomElement()!
        let street    = CountryData.indiaStreets.randomElement()!
        let houseNo   = Int.random(in: 1...250)

        // Индийские мобильные начинаются с 6/7/8/9, длина — 10 цифр.
        // Делим как: первые 5 цифр («area»), последние 5 — «number».
        let firstDigit = [6, 7, 8, 9].randomElement()!
        let mobile10 = "\(firstDigit)" + String((0..<9).map { _ in "0123456789".randomElement()! })
        let area = String(mobile10.prefix(5))
        let local = String(mobile10.suffix(5))

        return FakeProfile(
            country: .india,
            firstName: firstName,
            lastName: lastName,
            addressLine1: "\(houseNo), \(street)",
            addressLine2: "",
            city: cityInfo.city,
            region: cityInfo.state,
            postalCode: cityInfo.pins.randomElement()!,
            phoneAreaCode: area,
            phoneNumber: local
        )
    }

    // MARK: - Turkey

    private static func makeTurkey() -> FakeProfile {
        let firstName = CountryData.turkeyFirstNames.randomElement()!
        let lastName  = CountryData.turkeyLastNames.randomElement()!
        let cityInfo  = CountryData.turkeyCities.randomElement()!
        let street    = CountryData.turkeyStreets.randomElement()!
        let houseNo   = Int.random(in: 1...300)

        // Турецкий мобильный: 5XX XXX XX XX — без ведущего 0.
        let opCode = CountryData.turkeyMobileOperatorCodes.randomElement()!     // 5XX
        let mid    = String(format: "%03d", Int.random(in: 100...999))           // XXX
        let tail   = String(format: "%02d%02d", Int.random(in: 0...99), Int.random(in: 0...99)) // XX XX

        return FakeProfile(
            country: .turkey,
            firstName: firstName,
            lastName: lastName,
            addressLine1: "\(street) No: \(houseNo)",
            addressLine2: "",
            city: cityInfo.city,
            region: cityInfo.il,
            postalCode: cityInfo.codes.randomElement()!,
            phoneAreaCode: opCode,
            phoneNumber: "\(mid) \(tail)"
        )
    }

    // MARK: - Kazakhstan

    private static func makeKazakhstan() -> FakeProfile {
        let firstName = CountryData.kazakhstanFirstNames.randomElement()!
        let lastName  = CountryData.kazakhstanLastNames.randomElement()!
        let cityInfo  = CountryData.kazakhstanCities.randomElement()!
        let street    = CountryData.kazakhstanStreets.randomElement()!
        let houseNo   = Int.random(in: 1...250)
        let apt       = Int.random(in: 1...200)

        // Казахстанский мобильный: 7XX XXX-XX-XX.
        let opCode = CountryData.kazakhstanMobileCodes.randomElement()!         // 7XX
        let mid    = String(format: "%03d", Int.random(in: 100...999))           // XXX
        let tail   = String(format: "%02d-%02d", Int.random(in: 0...99), Int.random(in: 0...99)) // XX-XX

        return FakeProfile(
            country: .kazakhstan,
            firstName: firstName,
            lastName: lastName,
            addressLine1: "\(street), д. \(houseNo)",
            addressLine2: "кв. \(apt)",
            city: cityInfo.city,
            region: cityInfo.region,
            postalCode: cityInfo.codes.randomElement()!,
            phoneAreaCode: opCode,
            phoneNumber: "\(mid)-\(tail)"
        )
    }
}
