import SwiftUI

struct SearchView<ViewModelProtocol>: View where ViewModelProtocol: SearchViewModelProtocol {
    @ObservedObject private(set) var viewModel: ViewModelProtocol
    @State private var showCancelButton: Bool = false
    @Binding var selectedRestaurant: RestaurantModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            SearchBar(query: $viewModel.searchText, showCancelButton: $showCancelButton)
                .padding(.bottom, 10)

            Rectangle()
                .foregroundColor(Color.black)
                .frame(height: 0.4)
            List {
                ForEach(viewModel.cardModels) { model in
                    ListCard(content: model)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            selectedRestaurant = RestaurantModel(name: model.name, address: model.address,
                                                                 id: model.restaurantID)
                            print(model.restaurantID)
                            dismiss()
                        }
                }
            }
            .listStyle(.inset)
        }
        .onAppear { UIScrollView.appearance().keyboardDismissMode = .onDrag }
        .navigationBarHidden(true)
    }
}
