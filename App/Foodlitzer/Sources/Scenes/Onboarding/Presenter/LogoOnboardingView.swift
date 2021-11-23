import SwiftUI

struct LogoOnboardingView: View {
    var currentPage: Int
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Rectangle()
                    .fill(Color("logoGray"))
                    .opacity(0.21)
                    .rotationEffect(.degrees(45))
                    .frame(width: 223, height: 223)
                    .offset(x: -50)
                Rectangle()
                    .fill(Color("logoGray"))
                    .opacity(0.21)
                    .rotationEffect(.degrees(45))
                    .frame(width: 223, height: 223)
                    .offset(x: 50)
            }
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color("logoGray"))
                    .opacity(0.21)
                    .rotationEffect(.degrees(45))
                    .frame(width: 223, height: 223)
                VStack {
                    Text("foodlitzer")
                        .font(.custom("Lora-Regular", size: 51))

                    Text("Lorem ipsum dolor sit amet")
                        .font(.custom("Lora-Regular", size: 14))
                }.foregroundColor(.black)
            }.offset(y: -50)
            HStack {
                Rectangle()
                    .fill(Color("logoGray"))
                    .opacity(0.21)
                    .rotationEffect(.degrees(45))
                    .frame(width: 223, height: 223)
                    .offset(x: -50, y: -100)
                Rectangle()
                    .fill(Color("logoGray"))
                    .opacity(0.21)
                    .rotationEffect(.degrees(45))
                    .frame(width: 223, height: 223)
                    .offset(x: 50, y: -100)
            }

        }.background(Color.white)
    }
}

struct LogoOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        LogoOnboardingView(currentPage: 0)
    }
}
