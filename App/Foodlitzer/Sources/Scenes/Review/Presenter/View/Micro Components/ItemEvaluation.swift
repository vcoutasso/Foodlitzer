import SwiftUI

struct ItemEvaluation: View {
    @Binding var item: CGFloat
    var isEditing: Bool

    var restaurantFeatures: FeatureDefinition

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: restaurantFeatures.symbol)
                    .padding(4)
                    .background(Circle()
                        .strokeBorder(Color.black, lineWidth: 0.3)
                        .foregroundColor(.white))
                    .foregroundColor(.black)

                Text(restaurantFeatures.question)
                    .font(.compact(.regular, size: 14))
            }
            .padding(.bottom, 10)

            VStack(alignment: .leading) {
                Slider(value: $item, isEditing: isEditing)
                    .padding(.top, 20)

                HStack {
                    Text(restaurantFeatures.rate[0])
                    Spacer()
                    Text(restaurantFeatures.rate[1])
                }
                .font(.compact(.light, size: 12))
                .padding(.bottom, 35)
            }
            .padding(.horizontal, 30) // 50
            .border(Color.black, width: 0.3)
        }
    }
}
