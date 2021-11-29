import SwiftUI

struct TopInfoView: View {
    var restaurantName: String

    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text(restaurantName)
                    .frame(height: 33)
                    .padding(.horizontal, 10)
                    .font(.sfCompactText(.light, size: 14))

                Spacer()
            }
            .background(Color.white.border(Color.black, width: 0.3))
            .frame(height: 45)
            .fixedSize(horizontal: true, vertical: false)
            .padding(.horizontal, 30)
            .padding(.vertical, 10)

            Spacer()
        }
        .padding(.top, 10)

        .navigationBarTitleDisplayMode(.inline)
    }
}
