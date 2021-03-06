import SwiftUI

struct TemplateOnboardingPageView: View {
    var image: Image
    var text: String
    var body: some View {
        ZStack(alignment: .top) {
            image
                .padding(.top, 30)
            Text(text)
                .font(.custom("Lora-Regular", size: 34))
                .frame(width: 284, height: 139, alignment: .top)
                .multilineTextAlignment(.center)
        }
    }
}
