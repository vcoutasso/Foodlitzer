import SwiftUI

struct ButtonsOnboadingView<Destination: View>: View {
    var text: String
    var destination: () -> Destination

    init(text: String, destination: @escaping () -> Destination) {
        self.text = text
        self.destination = destination
    }

    var body: some View {
        NavigationLink(destination: destination()) {
            HStack {
                Text(text)
            }
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(.black)
            .frame(width: 310, height: 40, alignment: .center)
            .border(Color.black, width: 0.2)
        }
    }
}

struct ButtonsOnboadingView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsOnboadingView(text: "Continue with phone number") {
            EmptyView()
        }
    }
}
