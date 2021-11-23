import SwiftUI

struct BookmarkButton: View {
    var body: some View {
        Button {
            // Save action here
        } label: {
            Image(systemName: "bookmark")
                .font(.system(size: 18, weight: .regular, design: .default))
                .foregroundColor(.white)
                .padding(7)
                .background(Circle().foregroundColor(Color.black.opacity(0.35)))
        }
    }
}
