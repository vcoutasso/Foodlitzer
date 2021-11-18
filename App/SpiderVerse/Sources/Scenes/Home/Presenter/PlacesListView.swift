import SwiftUI

struct PlacesListView: View {
    @MainActor var viewModel: PlacesListViewModel

    var body: some View {
        ScrollView {
            VStack {
                Button {
                    viewModel.handleButtonTapped()
                } label: {
                    Text("hello")
                }
                ForEach(viewModel.places, id: \.self.placeID) { place in
                    Text(place.name ?? "")
                    Text(place.address ?? "")

                    // Image(uiImage: place.image)
                    //    .resizable()
                    //    .frame(width: 120, height: 120, alignment: .center)
                    // Text(place.attributions.string)
                }

            }.onAppear {
                viewModel.checkIfLocationServicesAreEnabled()
            }
        }
    }
}

#if DEBUG
    struct PlacesListView_Previews: PreviewProvider {
        static var previews: some View {
            PlacesListView(viewModel: PlacesListViewModel(nearbyPlacesService: NearbyPlacesService()))
        }
    }
#endif
