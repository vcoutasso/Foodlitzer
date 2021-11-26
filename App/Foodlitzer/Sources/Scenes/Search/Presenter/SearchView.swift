import SwiftUI

struct SearchView<ViewModelProtocol>: View where ViewModelProtocol: SearchViewModelProtocol {
    @ObservedObject private(set) var viewModel: ViewModelProtocol
    @State private var showCancelButton: Bool = false

    var body: some View {
        ScrollView {
            SearchBar(query: $viewModel.searchText, showCancelButton: $showCancelButton)

            // TODO: Botas os cards a partir do search

            Spacer()
        }
        .onAppear { UIScrollView.appearance().keyboardDismissMode = .onDrag }
        .background(Color("BackgroundColor"))
        .navigationBarHidden(true)
    }
}
