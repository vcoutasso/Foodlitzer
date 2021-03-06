import SwiftUI

struct ReviewedTag: View {
    var body: some View {
        HStack {
            Image(systemName: Strings.Symbols.reviewed)
            Text(Localizable.Tag.Reviewed.text)
        }
        .foregroundColor(.white)
        .padding(5)
        .font(.system(size: 12, weight: .regular, design: .default))
        .background(Capsule().foregroundColor(Color.black.opacity(0.35)))
    }
}
