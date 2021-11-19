import SwiftUI

struct HeaderComponent: View {
    var body: some View {
        HStack {
            Button {
                // Destination Here
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title3) // TODO: Change size
                    .foregroundColor(.black)
                    .padding()
            }

            Spacer()

            Text("foodlitzer")
                .font(Font.custom("Lora", size: 17)) // TODO: Font here

            Spacer()

            Button {
                // Destination Here
            } label: {
                Image(systemName: "gear")
                    .font(.title3) // TODO: Change size
                    .foregroundColor(.black)
                    .padding()
            }
        }
    }
}

struct HeaderComponentView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderComponent()
    }
}
