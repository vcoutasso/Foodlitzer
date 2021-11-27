import SwiftUI

struct LogoOnboardingView: View {
    var currentPage: Int
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Assets.Images.onionsDiamond.image
                    .offset(x: 10, y: 50)
                Assets.Images.newspaperDiamond.image
                    .offset(x: 20, y: 50)
            }
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color.white)
                    .rotationEffect(.degrees(45))
                    .frame(width: 223, height: 223)
                Assets.Images.brandLogo.image
            }.offset(y: -80)
            HStack {
                Assets.Images.newspaperDiamond.image
                    .offset(x: 8, y: -207)
                rectangleFish
            }

        }.background(Color("background"))
    }

    private var rectangleFish: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color("blueFish"))
                .rotationEffect(.degrees(45))
                .frame(width: 223, height: 223)
            Assets.Images.goldenFish.image
        }.offset(y: -210)
    }
}

struct LogoOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        LogoOnboardingView(currentPage: 0)
    }
}
