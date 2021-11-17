import SwiftUI

struct PlacesListView: View {
    @ObservedObject var viewModel: PlacesListViewModel
    var body: some View {
        ScrollView {
            VStack {
                Button {
                    viewModel.handleButtonTap()
                } label: {
                    Text("hello")
                }
                ForEach(viewModel.places) { place in
                    Text(place.name)
                    Text(place.address)

                    Image(uiImage: place.image)
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                    Text(place.attributions.string)
                }

            }.onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
        }
    }
}

#if DEBUG
    struct PlacesListView_Previews: PreviewProvider {
        static var previews: some View {
            PlacesListView(viewModel: PlacesListViewModel())
        }
    }
#endif
