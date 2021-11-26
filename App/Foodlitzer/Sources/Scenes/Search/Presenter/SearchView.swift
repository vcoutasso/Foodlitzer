import SwiftUI

struct SearchView<ViewModelProtocol>: View where ViewModelProtocol: SearchViewModelProtocol {
    @ObservedObject private(set) var viewModel: ViewModelProtocol
    @State private var showCancelButton: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            SearchBar(query: $viewModel.searchText, showCancelButton: $showCancelButton)
                .padding(.bottom, 10)

            // TODO: progressView enquanto pesquisa
            // TODO: dismiss swipe direita

            Rectangle()
                .foregroundColor(Color.black)
                .frame(height: 0.4)
            List {
                ForEach(viewModel.cardModels) { model in
                    ListCard(content: model)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.inset)
        }
        .onAppear { UIScrollView.appearance().keyboardDismissMode = .onDrag }
        .navigationBarHidden(true)
    }
}
