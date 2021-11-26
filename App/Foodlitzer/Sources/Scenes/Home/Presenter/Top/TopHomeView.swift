import SwiftUI

struct TopHomeView: View {
    @State var query: String = ""
    @State var showCancelButton: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            HeaderComponent(query: $query, showCancelButton: $showCancelButton)
                .padding(.vertical) // set final padding

            CustomSegmentedPicker()

            Rectangle()
                .frame(height: 0.5)

            Spacer()
        }
        .navigationBarHidden(true)
    }
}
