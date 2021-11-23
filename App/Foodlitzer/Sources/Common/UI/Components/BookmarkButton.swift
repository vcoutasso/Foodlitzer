import SwiftUI

struct BookmarkButton: View {
    var body: some View {
        Button {
            // TODO: Save action here, need to change bookmark to fill

        } label: {
            Image(systemName: Strings.Symbols.notSaved)
                .font(.system(size: 18, weight: .regular, design: .default))
                .foregroundColor(.white)
                .padding(7)
                .background(Circle().foregroundColor(Color.black.opacity(0.35)))
        }
    }
}
