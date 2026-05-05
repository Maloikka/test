import Foundation

/// Справочник реалистичных «липовых» данных для каждой страны.
/// Все данные — публично известные (распространённые имена, реальные города,
/// корректные форматы почтовых индексов и телефонных номеров), но конкретные
/// сочетания собираются случайным образом и не относятся к реальным людям.
enum CountryData {

    // MARK: - USA

    /// Распространённые мужские/женские имена в США.
    static let usaFirstNames = [
        "James", "John", "Robert", "Michael", "William", "David", "Richard",
        "Joseph", "Thomas", "Charles", "Christopher", "Daniel", "Matthew",
        "Anthony", "Mark", "Donald", "Steven", "Andrew", "Paul", "Joshua",
        "Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara",
        "Susan", "Jessica", "Sarah", "Karen", "Nancy", "Lisa", "Margaret",
        "Betty", "Sandra", "Ashley", "Kimberly", "Emily", "Donna", "Michelle"
    ]

    static let usaLastNames = [
        "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller",
        "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez",
        "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin",
        "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark",
        "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King",
        "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores"
    ]

    /// Реальные улицы, типичные для адресов в США.
    static let usaStreets = [
        "Main St", "Oak Ave", "Pine St", "Maple Ave", "Cedar Rd",
        "Elm St", "Park Ave", "Washington St", "Lake St", "Hill St",
        "Church St", "Center St", "River Rd", "Sunset Blvd", "Highland Ave",
        "Spring St", "School St", "Ridge Rd", "Forest Ave", "Lincoln St"
    ]

    /// Город → штат (двухбуквенный код) → почтовый индекс (5 цифр).
    /// Все значения — реально существующие, корректные ZIP-коды.
    struct USACity { let city: String; let stateCode: String; let stateName: String; let zips: [String] }
    static let usaCities: [USACity] = [
        USACity(city: "New York",      stateCode: "NY", stateName: "New York",       zips: ["10001","10011","10025","10128","10003"]),
        USACity(city: "Los Angeles",   stateCode: "CA", stateName: "California",     zips: ["90001","90024","90045","90064","90210"]),
        USACity(city: "Chicago",       stateCode: "IL", stateName: "Illinois",       zips: ["60601","60614","60629","60647","60657"]),
        USACity(city: "Houston",       stateCode: "TX", stateName: "Texas",          zips: ["77002","77007","77019","77024","77056"]),
        USACity(city: "Phoenix",       stateCode: "AZ", stateName: "Arizona",        zips: ["85003","85016","85021","85032","85044"]),
        USACity(city: "Philadelphia",  stateCode: "PA", stateName: "Pennsylvania",   zips: ["19102","19103","19121","19130","19146"]),
        USACity(city: "San Antonio",   stateCode: "TX", stateName: "Texas",          zips: ["78201","78209","78216","78229","78258"]),
        USACity(city: "San Diego",     stateCode: "CA", stateName: "California",     zips: ["92101","92103","92109","92117","92122"]),
        USACity(city: "Dallas",        stateCode: "TX", stateName: "Texas",          zips: ["75201","75204","75214","75219","75230"]),
        USACity(city: "Miami",         stateCode: "FL", stateName: "Florida",        zips: ["33101","33125","33131","33139","33156"]),
        USACity(city: "Orlando",       stateCode: "FL", stateName: "Florida",        zips: ["32801","32803","32806","32819","32825"]),
        USACity(city: "Boston",        stateCode: "MA", stateName: "Massachusetts",  zips: ["02108","02114","02116","02118","02215"]),
        USACity(city: "Seattle",       stateCode: "WA", stateName: "Washington",     zips: ["98101","98103","98109","98115","98122"]),
        USACity(city: "Atlanta",       stateCode: "GA", stateName: "Georgia",        zips: ["30303","30309","30318","30324","30342"]),
        USACity(city: "Denver",        stateCode: "CO", stateName: "Colorado",       zips: ["80202","80203","80206","80211","80220"])
    ]

    /// Действующие коды городов (area codes) в США.
    static let usaAreaCodes = [
        "212","332","646","718","917",   // New York
        "213","310","323","424","818",   // Los Angeles
        "312","773","872",                // Chicago
        "713","281","832",                // Houston
        "602","480","623",                // Phoenix
        "215","267","445",                // Philadelphia
        "210","726",                      // San Antonio
        "619","858",                      // San Diego
        "214","469","972",                // Dallas
        "305","786","954",                // Miami
        "407","321",                      // Orlando
        "617","857",                      // Boston
        "206","425",                      // Seattle
        "404","470","678",                // Atlanta
        "303","720"                       // Denver
    ]

    // MARK: - India

    static let indiaFirstNames = [
        "Aarav", "Vivaan", "Aditya", "Vihaan", "Arjun", "Sai", "Reyansh",
        "Krishna", "Ishaan", "Rohan", "Rahul", "Amit", "Rajesh", "Suresh",
        "Anil", "Sanjay", "Vikram", "Vijay", "Ravi", "Karan",
        "Saanvi", "Aanya", "Aadhya", "Aaradhya", "Anaya", "Diya", "Pari",
        "Riya", "Priya", "Pooja", "Neha", "Kavya", "Ananya", "Isha", "Sneha"
    ]

    static let indiaLastNames = [
        "Sharma", "Verma", "Singh", "Kumar", "Gupta", "Patel", "Shah",
        "Mehta", "Joshi", "Pandey", "Mishra", "Yadav", "Reddy", "Iyer",
        "Iyengar", "Nair", "Menon", "Pillai", "Rao", "Naidu",
        "Kapoor", "Chopra", "Khanna", "Malhotra", "Sinha", "Saxena",
        "Agarwal", "Bansal", "Goel", "Jain", "Banerjee", "Chatterjee",
        "Mukherjee", "Ghosh", "Das", "Bose", "Roy", "Dutta"
    ]

    static let indiaStreets = [
        "MG Road", "Nehru Street", "Gandhi Marg", "Park Street",
        "Brigade Road", "Linking Road", "Anna Salai", "Hill Road",
        "Mall Road", "Connaught Place", "Marine Drive", "Bandra West",
        "Sector 17", "Sector 22", "Karol Bagh", "Lajpat Nagar"
    ]

    /// Город → штат → корректный 6-значный PIN-код.
    struct IndiaCity { let city: String; let state: String; let pins: [String] }
    static let indiaCities: [IndiaCity] = [
        IndiaCity(city: "Mumbai",     state: "Maharashtra",     pins: ["400001","400020","400050","400070","400099"]),
        IndiaCity(city: "Pune",       state: "Maharashtra",     pins: ["411001","411014","411028","411038","411057"]),
        IndiaCity(city: "Delhi",      state: "Delhi",           pins: ["110001","110017","110024","110034","110092"]),
        IndiaCity(city: "Noida",      state: "Uttar Pradesh",   pins: ["201301","201304","201307","201310","201313"]),
        IndiaCity(city: "Bengaluru",  state: "Karnataka",       pins: ["560001","560034","560066","560078","560100"]),
        IndiaCity(city: "Mysuru",     state: "Karnataka",       pins: ["570001","570009","570017","570023"]),
        IndiaCity(city: "Chennai",    state: "Tamil Nadu",      pins: ["600001","600028","600040","600089","600119"]),
        IndiaCity(city: "Coimbatore", state: "Tamil Nadu",      pins: ["641001","641014","641028","641038"]),
        IndiaCity(city: "Hyderabad",  state: "Telangana",       pins: ["500001","500032","500049","500072","500084"]),
        IndiaCity(city: "Kolkata",    state: "West Bengal",     pins: ["700001","700016","700029","700053","700091"]),
        IndiaCity(city: "Ahmedabad",  state: "Gujarat",         pins: ["380001","380009","380015","380054","380058"]),
        IndiaCity(city: "Surat",      state: "Gujarat",         pins: ["395001","395007","395010","395017"]),
        IndiaCity(city: "Jaipur",     state: "Rajasthan",       pins: ["302001","302017","302020","302039"]),
        IndiaCity(city: "Lucknow",    state: "Uttar Pradesh",   pins: ["226001","226010","226020","226024"]),
        IndiaCity(city: "Chandigarh", state: "Chandigarh",      pins: ["160001","160017","160022","160036"])
    ]

    // MARK: - Turkey

    static let turkeyFirstNames = [
        "Mehmet", "Mustafa", "Ahmet", "Ali", "Hüseyin", "Hasan", "İbrahim",
        "İsmail", "Osman", "Ömer", "Yusuf", "Murat", "Emre", "Burak",
        "Can", "Cem", "Kerem", "Eren", "Mert", "Onur",
        "Fatma", "Ayşe", "Emine", "Hatice", "Zeynep", "Elif", "Meryem",
        "Şerife", "Sultan", "Hanife", "Esra", "Merve", "Büşra", "Selin",
        "Pınar", "Gül", "Aslı", "Deniz", "Sevgi", "Yasemin"
    ]

    static let turkeyLastNames = [
        "Yılmaz", "Kaya", "Demir", "Şahin", "Çelik", "Yıldız", "Yıldırım",
        "Öztürk", "Aydın", "Özdemir", "Arslan", "Doğan", "Kılıç", "Aslan",
        "Çetin", "Kara", "Koç", "Kurt", "Özkan", "Şimşek",
        "Polat", "Erdoğan", "Korkmaz", "Çakır", "Akın", "Yalçın",
        "Aksoy", "Tekin", "Bulut", "Yavuz", "Güneş", "Sezer",
        "Acar", "Bayraktar", "Toprak", "Mutlu", "Erol", "Soylu"
    ]

    static let turkeyStreets = [
        "Atatürk Caddesi", "İstiklal Caddesi", "Bağdat Caddesi",
        "Cumhuriyet Caddesi", "Barbaros Bulvarı", "Vatan Caddesi",
        "Mevlana Caddesi", "Gazi Mustafa Kemal Bulvarı",
        "İnönü Caddesi", "Fevzi Çakmak Caddesi", "Halaskargazi Caddesi",
        "Büyükdere Caddesi", "Tunalı Hilmi Caddesi", "Kızılay Meydanı"
    ]

    /// Город (иль) → корректный 5-значный почтовый индекс.
    struct TurkeyCity { let city: String; let il: String; let codes: [String] }
    static let turkeyCities: [TurkeyCity] = [
        TurkeyCity(city: "İstanbul", il: "İstanbul", codes: ["34000","34010","34100","34250","34360","34433","34710"]),
        TurkeyCity(city: "Ankara",   il: "Ankara",   codes: ["06000","06100","06300","06420","06530","06680","06800"]),
        TurkeyCity(city: "İzmir",    il: "İzmir",    codes: ["35000","35100","35220","35330","35450","35540","35720"]),
        TurkeyCity(city: "Bursa",    il: "Bursa",    codes: ["16000","16100","16200","16310","16450","16700"]),
        TurkeyCity(city: "Antalya",  il: "Antalya",  codes: ["07000","07100","07200","07300","07400","07600"]),
        TurkeyCity(city: "Adana",    il: "Adana",    codes: ["01000","01100","01250","01310","01410"]),
        TurkeyCity(city: "Konya",    il: "Konya",    codes: ["42000","42100","42250","42310","42400"]),
        TurkeyCity(city: "Gaziantep",il: "Gaziantep",codes: ["27000","27100","27200","27300","27400"]),
        TurkeyCity(city: "Mersin",   il: "Mersin",   codes: ["33000","33100","33200","33300","33400"]),
        TurkeyCity(city: "Kayseri",  il: "Kayseri",  codes: ["38000","38100","38200","38300","38400"]),
        TurkeyCity(city: "Eskişehir",il: "Eskişehir",codes: ["26000","26100","26200","26300"]),
        TurkeyCity(city: "Diyarbakır",il:"Diyarbakır",codes:["21000","21100","21200","21300"]),
        TurkeyCity(city: "Trabzon",  il: "Trabzon",  codes: ["61000","61100","61200","61300"]),
        TurkeyCity(city: "Samsun",   il: "Samsun",   codes: ["55000","55100","55200","55300"])
    ]

    /// Действующие коды операторов мобильной связи в Турции (без ведущего 0).
    /// Формат номера: 5XX XXX XX XX.
    static let turkeyMobileOperatorCodes = [
        "530","531","532","533","534","535","536","537","538","539",  // Turkcell
        "540","541","542","543","544","545","546","547","548","549",  // Vodafone
        "550","551","552","553","554","555","556","557","558","559"   // Türk Telekom
    ]

    // MARK: - Kazakhstan

    static let kazakhstanFirstNames = [
        "Нурлан", "Ержан", "Бауыржан", "Айдар", "Арман", "Серик", "Талгат",
        "Канат", "Болат", "Аскар", "Даурен", "Олжас", "Темирлан", "Алихан",
        "Дамир", "Руслан", "Бекзат", "Ерболат", "Жанибек", "Мадияр",
        "Айгуль", "Айнура", "Жанара", "Гульнара", "Динара", "Карлыгаш",
        "Назым", "Сауле", "Алия", "Асем", "Балжан", "Камила", "Жанна",
        "Мадина", "Айжан", "Алтынай", "Айдана", "Айсулу", "Меруерт"
    ]

    static let kazakhstanLastNames = [
        "Абдрахманов", "Алимов", "Ахметов", "Бекмуратов", "Жумабаев",
        "Касымов", "Кожахметов", "Кенжебаев", "Молдагулов", "Нурланов",
        "Оспанов", "Сагидуллин", "Сейтжанов", "Султанов", "Тлеубаев",
        "Турсунов", "Усенов", "Хасенов", "Шакиров", "Юсупов",
        "Ким", "Ли", "Цой", "Пак",
        "Серикбаев", "Сапарбаев", "Жакупов", "Куанышев", "Бактыбаев",
        "Алтаев", "Темирбаев", "Дюсембаев", "Орынбасаров", "Калиев"
    ]

    static let kazakhstanStreets = [
        "проспект Абая", "улица Достык", "проспект Назарбаева",
        "улица Сейфуллина", "улица Жибек Жолы", "проспект Аль-Фараби",
        "улица Толе би", "улица Богенбай батыра", "улица Кабанбай батыра",
        "улица Сатпаева", "проспект Республики", "улица Бейбитшилик",
        "улица Кенесары", "улица Иманова"
    ]

    /// Город → область → корректный 6-значный почтовый индекс.
    struct KZCity { let city: String; let region: String; let codes: [String] }
    static let kazakhstanCities: [KZCity] = [
        KZCity(city: "Алматы",      region: "город Алматы",         codes: ["050000","050010","050020","050040","050060","050100"]),
        KZCity(city: "Астана",      region: "город Астана",         codes: ["010000","010010","010020","010100","020000"]),
        KZCity(city: "Шымкент",     region: "город Шымкент",        codes: ["160000","160001","160005","160012","160019"]),
        KZCity(city: "Караганда",   region: "Карагандинская область", codes: ["100000","100008","100012","100019","100027"]),
        KZCity(city: "Актобе",      region: "Актюбинская область",  codes: ["030000","030005","030010","030017"]),
        KZCity(city: "Тараз",       region: "Жамбылская область",   codes: ["080000","080007","080012","080017"]),
        KZCity(city: "Павлодар",    region: "Павлодарская область", codes: ["140000","140005","140008","140012"]),
        KZCity(city: "Усть-Каменогорск", region: "Восточно-Казахстанская область", codes: ["070000","070002","070008","070012"]),
        KZCity(city: "Семей",       region: "область Абай",         codes: ["071400","071405","071410"]),
        KZCity(city: "Атырау",      region: "Атырауская область",   codes: ["060000","060005","060011"]),
        KZCity(city: "Костанай",    region: "Костанайская область", codes: ["110000","110005","110009"]),
        KZCity(city: "Кызылорда",   region: "Кызылординская область",codes:["120000","120002","120008"]),
        KZCity(city: "Уральск",     region: "Западно-Казахстанская область", codes: ["090000","090005","090012"]),
        KZCity(city: "Петропавловск", region: "Северо-Казахстанская область", codes: ["150000","150005","150011"]),
        KZCity(city: "Актау",       region: "Мангистауская область",codes: ["130000","130003","130007"]),
        KZCity(city: "Кокшетау",    region: "Акмолинская область",  codes: ["020000","020001","020008"]),
        KZCity(city: "Талдыкорган", region: "Жетысуская область",   codes: ["040000","040002","040008"]),
        KZCity(city: "Туркестан",   region: "Туркестанская область",codes: ["161200","161205","161210"])
    ]

    /// Действующие казахстанские коды мобильных операторов (без +7).
    /// Формат: 7XX XXX-XX-XX.
    static let kazakhstanMobileCodes = [
        "700","701","702","705","706","707","708","747","771","775","776","777","778"
    ]
}
