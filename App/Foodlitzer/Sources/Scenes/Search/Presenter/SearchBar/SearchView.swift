import SwiftUI

struct SearchView: View {
    @State var query: String = ""
    @State var showCancelButton: Bool = false

    init() {
        UIScrollView.appearance().keyboardDismissMode = .onDrag
    }

    var body: some View {
        ScrollView {
            SearchBar(query: $query, showCancelButton: $showCancelButton)

            // TODO: Botas os cards a partir do search

            ForEach {
                ListCard(restaurantName: <#T##String#>, restaurantRate: <#T##Int#>, address: <#T##String#>,
                         price: <#T##Int#>)
            }
            Spacer()
        }
        .background(Color("BackgroundColor"))
        .navigationBarHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
