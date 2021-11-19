import SwiftUI

struct PlacesListView: View {
    // MARK: - Properties

    @MainActor var viewModel: PlacesListViewModel
    @State private(set) var restaurants: [Model] = []

    var body: some View {
        ScrollView {
            VStack {
                Button {
                    viewModel.handleButtonTapped { restaurants in
                        self.restaurants = restaurants
                    }
                } label: {
                    Text("hello")
                }
                ForEach(restaurants) { place in
                    Text(place.name)
                    Text(place.address)
                    // Image(uiImage: place.image)
                    //    .resizable()
                    //    .frame(width: 120, height: 120, alignment: .center)
                    // Text(place.attributions.string)
                }

            }.onAppear {
                viewModel.handleOnAppear()
            }
        }
    }

    // MARK: - Inner types

    struct Model: Identifiable {
        let id = UUID()
        let name: String
        let address: String
    }
}

#if DEBUG
    struct PlacesListView_Previews: PreviewProvider {
        static var previews: some View {
            PlacesListView(viewModel: PlacesListViewModelFactory.make())
        }
    }
#endif
