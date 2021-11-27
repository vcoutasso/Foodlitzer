import SwiftUI

struct HeaderComponent: View {
    var body: some View {
        HStack {
            HeaderButtonView(text: "magnifyingglass") {
                SearchView(viewModel: SearchViewModelFactory.make())
//                SearchBar(query: $query, showCancelButton: $showCancelButton)
            }

            Spacer()

            Assets.Images.brandLettering.image

            Spacer()

            HeaderButtonView(text: "gear") {
                ProfileView(viewModel: ProfileViewModelFactory.make())
            }
        }
    }
}
