import SwiftUI

struct RootView: View {
    @StateObject private var vm = RegionFillerViewModel()

    var body: some View {
        NavigationStack {
            RegionFormView(vm: vm)
                .navigationTitle("Страна или регион")
                .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.dark) // как на референсе из задания
    }
}

#Preview {
    RootView()
}
