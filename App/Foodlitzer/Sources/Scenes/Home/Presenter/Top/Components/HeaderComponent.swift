import SwiftUI

struct HeaderComponent: View {
    @Binding var query: String
    @Binding var showCancelButton: Bool
    var body: some View {
        HStack {
            HeaderButtonView(text: "magnifyingglass") {
                SearchBar(query: $query, showCancelButton: $showCancelButton)
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
