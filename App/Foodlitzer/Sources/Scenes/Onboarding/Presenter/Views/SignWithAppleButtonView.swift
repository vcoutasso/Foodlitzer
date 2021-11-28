import SwiftUI

struct SignWithAppleButtonView: View {
    var body: some View {
        VStack {
            Button(action: {}, label: {
                HStack {
                    Image(systemName: "applelogo")
                    Text("Sign in with Apple")
                }
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.white)

            }).frame(width: 310, height: 40, alignment: .center)

        }.background(Color.black)
    }
}

#if DEBUG
    struct SingWithAppleButtonView_Previews: PreviewProvider {
        static var previews: some View {
            SignWithAppleButtonView()
        }
    }
#endif
