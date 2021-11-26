import SwiftUI

struct SearchView: View {
    @State var query: String = ""
    @State var showCancelButton: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            SearchBar(query: $query, showCancelButton: $showCancelButton)
                .padding(.bottom, 10)

            Rectangle()
                .foregroundColor(Color.black)
                .frame(height: 0.4)
            List {
                ForEach(1..<5) { _ in
                    ListCard(restaurantName: "daskldal", restaurantRate: 3, address: "dals;kdasl;", price: 4)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.inset)
        }
        .navigationBarHidden(true)
        .onAppear {
            UIScrollView.appearance().keyboardDismissMode = .onDrag
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
