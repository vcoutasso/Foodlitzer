import SwiftUI

struct TopHomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            HeaderComponent()
                .padding(.vertical) // set final padding

            CustomSegmentedPicker()

            Rectangle()
                .frame(height: 0.5)

            Spacer()
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopHomeView()
    }
}