import Foundation

enum Country: String, CaseIterable, Identifiable, Hashable {
    case usa
    case india
    case turkey
    case kazakhstan

    var id: String { rawValue }

    var flag: String {
        switch self {
        case .usa: return "🇺🇸"
        case .india: return "🇮🇳"
        case .turkey: return "🇹🇷"
        case .kazakhstan: return "🇰🇿"
        }
    }

    /// Локализованное название страны (ru), как отображается в системе iOS.
    var titleRu: String {
        switch self {
        case .usa: return "Соединённые Штаты"
        case .india: return "Индия"
        case .turkey: return "Турция"
        case .kazakhstan: return "Казахстан"
        }
    }

    /// Английское название страны.
    var titleEn: String {
        switch self {
        case .usa: return "United States"
        case .india: return "India"
        case .turkey: return "Turkey"
        case .kazakhstan: return "Kazakhstan"
        }
    }

    /// Код страны для номера телефона (без «+»).
    var phoneCode: String {
        switch self {
        case .usa: return "1"
        case .india: return "91"
        case .turkey: return "90"
        case .kazakhstan: return "7"
        }
    }

    /// Подпись для региональной административной единицы:
    /// «Штат» — для США/Индии, «Иль» — для Турции, «Область» — для Казахстана.
    var regionFieldTitle: String {
        switch self {
        case .usa: return "Штат"
        case .india: return "Штат"
        case .turkey: return "Иль"
        case .kazakhstan: return "Область"
        }
    }
}
