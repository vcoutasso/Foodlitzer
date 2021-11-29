import SwiftUI

struct RestaurantsSearchBlock: View {
    @Binding var query: String
    @Binding var selectedRestaurant: RestaurantModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(Localizable.NewReview.BasicInfo.text)
                .font(.sfCompactText(.regular, size: 14))
                .padding(.bottom, 15)
                .padding(.horizontal, 40)

            NavigationLink {
                SearchView(viewModel: SearchViewModelFactory.make(), selectedRestaurant: $selectedRestaurant)
            } label: {
                HStack {
                    Image(systemName: Strings.Symbols.search)
                        .frame(height: 35)
                        .padding(10)
                        .foregroundColor(Color.black.opacity(0.5))

                    Text(Localizable.Search.Placeholder.text)
                        .foregroundColor(Color.black.opacity(0.5))
                        .font(.sfCompactText(.light, size: 14))

                    Spacer()
                }
                .background(Rectangle()
                    .foregroundColor(Color.clear)
                    .customStroke()
                    .font(.sfCompactText(.light, size: 14))
                    .frame(height: 35))
                .padding(.horizontal, 40)
            }

            // TODO: open search view!
        }

        HStack {
            Spacer()
            Rectangle()
                .frame(width: 155, height: 0.5, alignment: .center)
            Spacer()
        }
        .padding(.horizontal, 40)
    }
}
