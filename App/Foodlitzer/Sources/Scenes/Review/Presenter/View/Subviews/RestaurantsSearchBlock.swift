import SwiftUI

struct RestaurantsSearchBlock: View {
    @Binding var query: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Informações básicas")
                .font(.compact(.regular, size: 14))
                .padding(.bottom, 15)

            SearchBar(query: $query, showCancelButton: .constant(false))
            // TODO: open search view!!!
        }
        .padding(.horizontal, 40)

        HStack {
            Spacer()
            Rectangle()
                .frame(width: 155, height: 0.5, alignment: .center)
            Spacer()
        }
        .padding(.horizontal, 40)
    }
}
