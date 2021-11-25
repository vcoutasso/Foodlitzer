import SwiftUI

struct UserRatingBlock: View {
    @Binding var userRate: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Dê sua nota para o restaurante:")
                .font(.compact(.regular, size: 14))
                .padding(.bottom, 10)

            UserRate(rating: $userRate)
        }
        .padding(.bottom, 100)
    }
}
