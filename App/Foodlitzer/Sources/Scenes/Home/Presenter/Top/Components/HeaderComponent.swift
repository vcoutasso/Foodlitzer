import SwiftUI

struct HeaderComponent: View {
    var body: some View {
        HStack {
            Button {
                // Destination Here
            } label: {
                Image(systemName: Strings.Symbols.search)
                    .font(.title3) // TODO: Change size
                    .foregroundColor(.black)
                    .padding()
            }

            Spacer()

            Text("foodlitzer")
                .font(.lora(.regular, size: 17))

            Spacer()

            Button {
                // Destination Here
            } label: {
                Image(systemName: Strings.Symbols.settings)
                    .font(.title3) // TODO: Change size
                    .foregroundColor(.black)
                    .padding()
            }
        }
    }
}
