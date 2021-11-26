import SwiftUI

struct SearchView: View {
    @State var query: String = ""
    @State var showCancelButton: Bool = false

    var color = "BackgroundColor"

    init() {
        UIScrollView.appearance().keyboardDismissMode = .onDrag
        UITableView.appearance().backgroundColor = UIColor.clear
    }

    var body: some View {
        VStack(spacing: 0) {
            SearchBar(query: $query, showCancelButton: $showCancelButton)
                .padding(.bottom, 10)
                .background(Color(color).edgesIgnoringSafeArea(.all))

            Rectangle()
                .foregroundColor(Color.black)
                .frame(height: 0.4)
            List {
                ForEach(1..<5) { _ in
                    ListCard(restaurantName: "daskldal", restaurantRate: 3, address: "dals;kdasl;", price: 4)
                        .listRowSeparator(.hidden, edges: .bottom)
                        .listRowBackground(Color(color))
                }
                .background(Color(color).edgesIgnoringSafeArea(.all))

                Spacer()
            }
            .listStyle(.inset)
            .background(Color(color).edgesIgnoringSafeArea(.all))

            Spacer()
        }
        .background(Color(color).edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
