import SwiftUI

struct OpenRegisterView<Destination: View>: View {
    var destination: () -> Destination

    init(destination: @escaping () -> Destination) {
        self.destination = destination
    }

    var body: some View {
        NavigationLink(destination: destination()) {
            HStack {
                Text("Sign Up")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }
        }
    }
}

struct OpenRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        OpenRegisterView {
            EmptyView()
        }
    }
}
