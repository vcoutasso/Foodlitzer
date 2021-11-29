import SwiftUI

struct LogoOnboardingView: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(Assets.Images.onionsDiamond)
                    .offset(x: 10, y: 50)
                Image(Assets.Images.newspaperDiamond)
                    .offset(x: 20, y: 50)
            }
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color.white)
                    .rotationEffect(.degrees(45))
                    .frame(width: 223, height: 223)
                Image(Assets.Images.foodlitzerLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 243, height: 110)
            }.offset(y: -80)
            HStack {
                Image(Assets.Images.newspaperDiamond)
                    .offset(x: 8, y: -207)
                rectangleFish
            }

        }.background(Color(Assets.Colors.backgroundGray))
    }

    private var rectangleFish: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color("blueFish"))
                .rotationEffect(.degrees(45))
                .frame(width: 223, height: 223)
            Image("Images/goldenFish")
        }.offset(y: -210)
    }
}

#if DEBUG
    struct LogoOnboardingView_Previews: PreviewProvider {
        static var previews: some View {
            LogoOnboardingView()
        }
    }
#endif
