import SwiftUI

struct LogoOnboardingView: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image("cebola")
                    .offset(x: 10, y: 50)
                Image("newspaperLosango1")
                    .offset(x: 20, y: 50)
            }
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color.white)
                    .rotationEffect(.degrees(45))
                    .frame(width: 223, height: 223)
                Image("foodlitzerLogo")
            }.offset(y: -80)
            HStack {
                Image("newspaperLosango2")
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
            Image("fish")
        }.offset(y: -210)
    }
}

struct LogoOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        LogoOnboardingView()
    }
}
