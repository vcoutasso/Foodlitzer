import SwiftUI

struct PlacesListView: View {
    // MARK: - Properties

    @MainActor var viewModel: PlacesListViewModel
    @State private(set) var restaurants: [Model] = []

    var body: some View {
        ScrollView {
            VStack {
                Button {
                    DispatchQueue.main.async {
                        viewModel.handleButtonTapped { restaurants in
                            self.restaurants = restaurants
                        }
                    }
                } label: {
                    Text("hello")
                }
                ForEach(restaurants) { place in
                    Text(place.name)
                    Text(place.address)
                    place.images[0]
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                }

            }.onAppear {
                viewModel.handleOnAppear()
            }
        }
    }

    // MARK: - Inner types

    struct Model: Identifiable {
        let id: String
        let name: String
        let address: String
        let images: [Image]
    }
}

#if DEBUG
    struct PlacesListView_Previews: PreviewProvider {
        static var previews: some View {
            PlacesListView(viewModel: PlacesListViewModelFactory.make())
        }
    }
#endif
