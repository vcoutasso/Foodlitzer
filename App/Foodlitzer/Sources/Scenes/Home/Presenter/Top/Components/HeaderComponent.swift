import SwiftUI

struct HeaderComponent: View {
    var body: some View {
        HStack {
            HeaderButtonView(text: "magnifyingglass") {
                // SearchBar(query: $query, showCancelButton: $showCancelButton)
                EmptyView()
            }

            Spacer()

            Text("foodlitzer")
                .font(.lora(.regular, size: 17))

            Spacer()

            HeaderButtonView(text: "gear") {
                ProfileView(viewModel: ProfileViewModelFactory.make())
            }
        }
    }
}
