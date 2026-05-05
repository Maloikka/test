# Region Filler — iOS

Помощник для смены региона Apple ID. Приложение генерирует реалистичные «липовые»
данные (имя, фамилия, адрес, город, штат/иль/область, индекс, телефон) под
4 страны: 🇺🇸 США, 🇮🇳 Индия, 🇹🇷 Турция, 🇰🇿 Казахстан.

UI повторяет системный экран **«Страна или регион»**. Рядом с каждым полем —
кнопка копирования. Открыл системную форму смены региона → тапнул по полю →
вставил.

---

## Содержание

- [Зачем оно вообще, если iOS не даёт автозамену региона](#зачем-оно-вообще)
- [Как этим пользоваться (когда уже стоит)](#как-этим-пользоваться)
- [Сборка и запуск (3 пути)](#сборка-и-запуск)
  - [Вариант A — Mac + Xcode (быстро, проще всего)](#вариант-a)
  - [Вариант B — TestFlight через GitHub Actions (без Mac)](#вариант-b)
  - [Вариант C — fastlane на Mac (одной командой в TestFlight)](#вариант-c)
- [Подготовка Apple Developer & App Store Connect](#подготовка-apple)

---

## Зачем оно вообще

iOS **не позволяет** сторонним приложениям автоматически менять регион Apple
ID и заполнять системную форму Country/Region. Это закрытая часть Apple
(Settings → Apple ID → Media & Purchases → View Account → Country/Region),
к ней нет публичных API. Любое стороннее приложение работает в sandbox —
дотянуться до этой формы оно не может, и в App Store такое не пропустят.

Поэтому максимум, что может сделать честное приложение — подготовить
корректные данные и дать удобно вставлять их по одному полю или скопом.
Что и делает Region Filler.

## Как этим пользоваться

1. Открой Region Filler, в верхнем пикере выбери страну.
2. Открой **Настройки → Apple ID → Медиаматериалы и покупки → Просмотреть
   → Страна/регион**.
3. Тапай по нужному полю в системной форме и вставляй значение, скопированное
   из Region Filler (по кнопке копирования или «Скопировать все данные»).

---

## Сборка и запуск

### Вариант A

#### Mac + Xcode + бесплатный Apple ID

Самый простой способ запустить «здесь и сейчас», но не через TestFlight —
просто прямой запуск с Mac на твой iPhone.

```bash
brew install xcodegen
git clone https://github.com/Maloikka/test.git
cd test
git checkout cursor/ios-region-filler-app-8db0
xcodegen generate
open RegionFiller.xcodeproj
```

В Xcode:
- Подключи iPhone кабелем, на «Доверять компьютеру?» → **Доверять**.
- Сверху выбери свой iPhone (не симулятор).
- Открой проект `RegionFiller` → таб **Signing & Capabilities** → отметь
  **Automatically manage signing** → в **Team** выбери свой Apple ID.
- Если bundle id занят — поменяй `PRODUCT_BUNDLE_IDENTIFIER` на свой
  (например, `com.<твоё имя>.regionfiller`).
- Нажми **Run** (`⌘R`).

Первый запуск на iPhone — система скажет «Untrusted Developer». Лечится:
**Настройки → Основные → VPN и управление устройством → твой Apple ID →
Доверять**.

> Бесплатный Apple ID — подпись действует **7 дней**. Через неделю запусти из
> Xcode заново. С платным Apple Developer Program ($99/год) — 1 год.

---

### Вариант B

#### TestFlight через GitHub Actions (без Mac)

Это то, что ты просил. Сборка `.ipa` целиком происходит на macOS-раннере
GitHub Actions, после чего билд автоматически загружается в TestFlight.
**Нужен платный Apple Developer Program ($99/год)** — TestFlight без него
не работает.

#### B.0. Чек-лист, что должно быть готово

- [ ] Apple Developer Program оплачен ($99/год) → [developer.apple.com/programs](https://developer.apple.com/programs/)
- [ ] App Store Connect API key (`.p8`) с ролью **App Manager**
- [ ] Distribution-сертификат (`.p12`) и пароль от него
- [ ] App Store provisioning profile (`.mobileprovision`)
- [ ] App ID и приложение, заведённое в App Store Connect

Подробно про каждый пункт — в разделе [«Подготовка Apple Developer
& App Store Connect»](#подготовка-apple). Сначала пройди его, потом
возвращайся сюда.

#### B.1. Положить секреты в GitHub

В репозитории: **Settings → Secrets and variables → Actions → New repository
secret**. Нужно завести следующие секреты:

| Имя секрета | Что туда положить |
|---|---|
| `BUNDLE_ID` | Твой bundle id, напр. `com.yourcompany.regionfiller` |
| `TEAM_ID` | Team ID из Apple Developer (10 символов, напр. `ABCDE12345`) |
| `ASC_KEY_ID` | Key ID из App Store Connect API (напр. `XXXXXXXXXX`) |
| `ASC_ISSUER_ID` | Issuer ID из App Store Connect API (UUID) |
| `ASC_KEY_P8_BASE64` | Содержимое файла `AuthKey_XXXX.p8`, закодированное в base64 (см. ниже) |
| `DIST_CERT_P12_BASE64` | Содержимое distribution-сертификата `.p12` в base64 |
| `DIST_CERT_PASSWORD` | Пароль от `.p12` (тот, что задавал при экспорте из Keychain) |
| `PROVISIONING_PROFILE_BASE64` | Содержимое `.mobileprovision` в base64 |
| `PROVISIONING_PROFILE_NAME` | Имя профиля как в Apple Developer Portal, напр. `RegionFiller AppStore` |
| `KEYCHAIN_PASSWORD` | Любая случайная строка (используется только внутри CI) |

Чтобы получить base64 (на Mac/Linux):

```bash
base64 -i AuthKey_XXXXXXXXXX.p8 | tr -d '\n' | pbcopy   # macOS
base64 -w 0 AuthKey_XXXXXXXXXX.p8                       # Linux
```

То же самое для `.p12` и `.mobileprovision`. Скопированную строку и кладёшь
в GitHub Secret.

> Если у тебя сейчас Windows и ничего, кроме iPhone — base64-кодировку можно
> сделать прямо в браузере (например, на base64.guru), но имей в виду:
> файлы `.p8` / `.p12` — это твои приватные ключи. Не загружай их на чужие
> сайты. Безопаснее: попроси кого-то с Mac/Linux сделать это локально, или
> сделай это в WSL на Windows.

#### B.2. Запустить сборку

В GitHub: вкладка **Actions** → слева workflow **iOS — Build & Upload to
TestFlight** → справа **Run workflow** → ввести версию (например, `1.0.0`)
→ **Run**.

Через ~15 минут:
- В Actions появится артефакт `RegionFiller-ipa` — можно скачать `.ipa`
  напрямую (хранится 14 дней).
- В **App Store Connect → твоё приложение → TestFlight → iOS Builds**
  появится новый билд со статусом «Processing» (процессинг занимает ещё
  10–60 минут со стороны Apple).

#### B.3. Поставить на iPhone через TestFlight

1. На iPhone установи **TestFlight** из App Store ([apps.apple.com/app/testflight/id899247664](https://apps.apple.com/app/testflight/id899247664)).
2. В App Store Connect → **TestFlight → Internal Testing** → создай группу
   (напр. «Me»), добавь себя как тестировщика по тому Apple ID, под которым
   ты залогинен на iPhone (он должен быть в Users & Access твоей команды).
3. Когда билд пройдёт процессинг — добавь его в группу.
4. На iPhone придёт письмо/нотификация → открой ссылку → согласишься
   тестировать → в TestFlight появится Region Filler → **Install**.

Готово. Дальше любая новая сборка — `Run workflow` → новый build number →
TestFlight сам обновит приложение.

---

### Вариант C

#### fastlane на Mac (одной командой)

Если у тебя уже есть Mac, и ты не хочешь возиться с GitHub Secrets —
fastlane делает то же самое локально:

```bash
# 1. Один раз — поставить тулзы
brew install xcodegen
sudo gem install bundler
bundle install

# 2. Заполнить .env (см. .env.example)
cp .env.example .env
$EDITOR .env

# 3. Собрать и залить в TestFlight
bundle exec fastlane beta
```

`fastlane/Fastfile` уже настроен: он сгенерирует проект через xcodegen,
поднимет build number, соберёт `.ipa`, подпишется через App Store Connect
API key (или fastlane match, если задан `MATCH_GIT_URL`) и зальёт билд в
TestFlight.

---

## Подготовка Apple

Если ничего из перечисленного ниже у тебя ещё нет — пройди по шагам один
раз. Дальше CI / fastlane делают всё сами.

### 1. Apple Developer Program

[developer.apple.com/programs/enroll](https://developer.apple.com/programs/enroll/)
→ оплати $99/год. Без этого ни TestFlight, ни нормальная подпись `.ipa` не
работают.

### 2. Bundle ID и приложение в App Store Connect

1. [App Store Connect](https://appstoreconnect.apple.com/) → **My Apps → +**.
2. Platform: iOS, Name: `Region Filler`, Primary language: Russian, Bundle ID:
   зарегистрируй новый (например, `com.yourcompany.regionfiller`) — для этого
   сначала создай его в [Certificates, Identifiers & Profiles → Identifiers
   → +](https://developer.apple.com/account/resources/identifiers/list).
3. Запиши значение Bundle ID — это твой `BUNDLE_ID`.

### 3. Team ID

[developer.apple.com/account](https://developer.apple.com/account) →
**Membership Details → Team ID**. 10 символов (например `ABCDE12345`).
Это твой `TEAM_ID`.

### 4. App Store Connect API key

[App Store Connect → Users and Access → Integrations → App Store Connect API
→ Keys → +](https://appstoreconnect.apple.com/access/api).

- Name: `RegionFiller CI`
- Access: **App Manager**
- → **Generate**

Сразу скачай `.p8` файл — Apple даёт скачать его **только один раз**.
- **Key ID** → твой `ASC_KEY_ID`
- **Issuer ID** (вверху страницы) → твой `ASC_ISSUER_ID`
- Содержимое `.p8` в base64 → `ASC_KEY_P8_BASE64`

### 5. Distribution-сертификат

На Mac:
1. Keychain Access → **Certificate Assistant → Request a Certificate from a
   Certificate Authority** → сохранить `.certSigningRequest`.
2. [developer.apple.com → Certificates → +](https://developer.apple.com/account/resources/certificates/list)
   → **Apple Distribution** → загрузить CSR → скачать `.cer`.
3. Дважды кликнуть `.cer` — он установится в Keychain.
4. В Keychain раскрыть сертификат, выделить и сертификат, и приватный ключ
   под ним → правой кнопкой **Export 2 items** → формат `.p12` → задать
   пароль.
5. Содержимое `.p12` в base64 → `DIST_CERT_P12_BASE64`,
   пароль → `DIST_CERT_PASSWORD`.

> Если Mac нет совсем — можно сгенерировать ключ через `openssl` на Linux,
> CSR, и подгрузить в Apple Developer Portal. Это длиннее, но рабочий путь.
> Скажи — распишу отдельно.

### 6. Provisioning profile

[developer.apple.com → Profiles → +](https://developer.apple.com/account/resources/profiles/list):
- Type: **App Store** (Distribution)
- App ID: твой `BUNDLE_ID`
- Сертификат: тот, что сделал на шаге 5
- Name: например, `RegionFiller AppStore`
- → **Generate** → скачать `.mobileprovision`.

- Имя → `PROVISIONING_PROFILE_NAME`
- Содержимое в base64 → `PROVISIONING_PROFILE_BASE64`

---

## Структура проекта

```
RegionFiller/
├── App/RegionFillerApp.swift
├── Models/{Country.swift, FakeProfile.swift}
├── Data/{CountryData.swift, ProfileGenerator.swift}
├── ViewModel/RegionFillerViewModel.swift
├── Views/{RootView.swift, RegionFormView.swift}
└── Info.plist
project.yml                       # XcodeGen
fastlane/{Fastfile, Appfile}      # локальная сборка с Mac
.github/workflows/ios-testflight.yml  # сборка .ipa и аплоад в TestFlight
Gemfile                           # ruby-зависимости (fastlane)
.env.example                      # шаблон локальных переменных
```

Зависимостей у самого приложения нет. Минимальная iOS — 16.0.
