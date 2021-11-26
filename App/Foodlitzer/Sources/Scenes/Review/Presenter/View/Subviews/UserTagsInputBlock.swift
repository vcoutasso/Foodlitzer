import SwiftUI

struct UserTagsInputBlock: View {
    @Binding var currentTag: String
    @Binding var tags: [String]
    @Binding var isShowingKeyboard: Bool

    var body: some View {
        VStack(alignment: .leading) {
            TagTextField(currentTag: $currentTag, tags: $tags,
                         isKeyboadShowing: $isShowingKeyboard) // TODO: o teclado da dismiss automaticamente ao pressionar return

            FlexibleView(data: tags, spacing: 8, alignment: .leading) { tag in
                Button {
                    withAnimation {
                        if let index = tags.firstIndex(of: tag) {
                            tags.remove(at: index)
                        }
                    }
                } label: {
                    HStack {
                        Text(tag)
                            .font(.compact(.light, size: 12))
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 12, weight: .regular, design: .default))
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 2)
                    .foregroundColor(.black)
                    .background(Capsule().stroke(Color.black, lineWidth: 0.3))
                }
            }
            .padding(.bottom, 20)
        }
    }
}
