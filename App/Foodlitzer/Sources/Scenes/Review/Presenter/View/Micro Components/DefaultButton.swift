import SwiftUI

struct DefaultButton: View {
    var label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.sfCompactText(.regular, size: 14))
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 80, height: 40)
                .background(Color.black)
        }
    }
}
