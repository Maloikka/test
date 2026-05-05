import SwiftUI
import UIKit

struct RegionFormView: View {
    @ObservedObject var vm: RegionFillerViewModel
    @State private var copiedField: String?

    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                countrySection
                paymentSection
                billingNameSection
                addressSection
                actionsSection
                hintSection
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color(.systemBackground))

            footerBar
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 0)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Назад") {}.disabled(true).foregroundStyle(.blue)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Далее") {}.disabled(true).foregroundStyle(.blue.opacity(0.6))
            }
        }
        .overlay(alignment: .top) {
            if let copiedField {
                ToastView(text: "Скопировано: \(copiedField)")
                    .padding(.top, 8)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }

    // MARK: - Sections

    private var countrySection: some View {
        Section {
            Picker(selection: $vm.country) {
                ForEach(Country.allCases) { c in
                    HStack {
                        Text(c.flag)
                        Text(c.titleRu)
                    }.tag(c)
                }
            } label: {
                LabeledContent("Страна или регион") {
                    Text("\(vm.country.flag) \(vm.country.titleRu)")
                        .foregroundStyle(.secondary)
                }
            }
            .pickerStyle(.menu)
        } header: {
            Text("Регион")
        } footer: {
            Text("Выберите регион — данные ниже сгенерируются автоматически.")
        }
    }

    private var paymentSection: some View {
        Section {
            ForEach(PaymentMethod.allCases) { method in
                Button {
                    vm.paymentMethod = method
                } label: {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(method.rawValue).foregroundStyle(.primary)
                            if let subtitle = method.subtitle {
                                Text(subtitle).font(.footnote).foregroundStyle(.secondary)
                            }
                        }
                        Spacer()
                        if vm.paymentMethod == method {
                            Image(systemName: "checkmark").foregroundStyle(.blue)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        } header: {
            Text("Способ оплаты")
        } footer: {
            Text("Средства будут списаны только после совершения покупки.")
        }
    }

    private var billingNameSection: some View {
        Section("Получатель выставленного счёта") {
            CopyableRow(title: "Имя",     value: vm.profile.firstName, onCopy: copy)
            CopyableRow(title: "Фамилия", value: vm.profile.lastName,  onCopy: copy)
        }
    }

    private var addressSection: some View {
        Section("Адрес для выставления счёта") {
            CopyableRow(title: "Адрес", value: vm.profile.addressLine1, onCopy: copy)
            CopyableRow(title: "Адрес", value: vm.profile.addressLine2.isEmpty ? "Необязательно" : vm.profile.addressLine2,
                        valueIsPlaceholder: vm.profile.addressLine2.isEmpty,
                        onCopy: copy)
            CopyableRow(title: "Город", value: vm.profile.city, onCopy: copy)
            CopyableRow(title: vm.country.regionFieldTitle, value: vm.profile.region, onCopy: copy)
            CopyableRow(title: "Индекс", value: vm.profile.postalCode, onCopy: copy)
            HStack(spacing: 12) {
                Text("Номер телефона")
                Spacer()
                Text("+\(vm.country.phoneCode)")
                    .foregroundStyle(.secondary)
                Text(vm.profile.phoneAreaCode)
                    .frame(minWidth: 56, alignment: .leading)
                Text(vm.profile.phoneNumber)
                Button {
                    copy("+\(vm.country.phoneCode) \(vm.profile.phoneAreaCode) \(vm.profile.phoneNumber)",
                         field: "Телефон")
                } label: {
                    Image(systemName: "doc.on.doc")
                }
                .buttonStyle(.borderless)
                .foregroundStyle(.blue)
            }
        }
    }

    private var actionsSection: some View {
        Section {
            Button {
                copyAll()
            } label: {
                Label("Скопировать все данные", systemImage: "square.on.square.dashed")
            }

            Button {
                withAnimation { vm.regenerate() }
            } label: {
                Label("Сгенерировать заново", systemImage: "arrow.triangle.2.circlepath")
            }
        }
    }

    private var hintSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                Text("Как пользоваться")
                    .font(.headline)
                Text("""
1. Выберите страну сверху.
2. Откройте Настройки → Apple ID → Медиаматериалы и покупки → Просмотреть → Страна/регион.
3. В системной форме тапните по нужному полю и вставьте значение из этого приложения (кнопка справа от поля).

Apple не разрешает сторонним приложениям заполнять системную форму региона автоматически — это можно сделать только вручную копированием/вставкой.
""")
                .font(.footnote)
                .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)
        }
    }

    private var footerBar: some View {
        HStack {
            Text("Страна или регион:")
                .foregroundStyle(.secondary)
            Text(vm.country.titleRu)
                .foregroundStyle(.primary)
            Spacer()
        }
        .font(.footnote)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
    }

    // MARK: - Helpers

    private func copy(_ value: String, field: String) {
        guard !value.isEmpty else { return }
        UIPasteboard.general.string = value
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        withAnimation { copiedField = field }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            withAnimation { if copiedField == field { copiedField = nil } }
        }
    }

    private func copyAll() {
        let p = vm.profile
        let text = """
        \(p.firstName) \(p.lastName)
        \(p.addressLine1)
        \(p.city), \(p.region) \(p.postalCode)
        \(vm.country.titleEn)
        \(p.fullPhone)
        """
        UIPasteboard.general.string = text
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        withAnimation { copiedField = "все поля" }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            withAnimation { if copiedField == "все поля" { copiedField = nil } }
        }
    }
}

// MARK: - CopyableRow

private struct CopyableRow: View {
    let title: String
    let value: String
    var valueIsPlaceholder: Bool = false
    let onCopy: (String, String) -> Void

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(valueIsPlaceholder ? .secondary : .primary)
                .lineLimit(1)
                .truncationMode(.middle)
            Button {
                if !valueIsPlaceholder { onCopy(value, title) }
            } label: {
                Image(systemName: "doc.on.doc")
            }
            .buttonStyle(.borderless)
            .foregroundStyle(valueIsPlaceholder ? .gray : .blue)
            .disabled(valueIsPlaceholder)
        }
    }
}

// MARK: - Toast

private struct ToastView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.footnote.weight(.medium))
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(.ultraThinMaterial, in: Capsule())
            .overlay(Capsule().stroke(.white.opacity(0.1)))
            .shadow(radius: 6)
    }
}

#Preview {
    NavigationStack {
        RegionFormView(vm: RegionFillerViewModel())
            .navigationTitle("Страна или регион")
            .navigationBarTitleDisplayMode(.inline)
    }
    .preferredColorScheme(.dark)
}
