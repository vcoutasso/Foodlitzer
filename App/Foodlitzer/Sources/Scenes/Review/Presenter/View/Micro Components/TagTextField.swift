import SwiftUI

struct TagTextField: View {
    @Binding var currentTag: String
    @Binding var tags: [String]
    @Binding var isKeyboadShowing: Bool

    var body: some View {
        VStack {
            TextField("Add some tags", text: $currentTag, onEditingChanged: { isEditing in
                isKeyboadShowing = isEditing
            })
            .frame(width: 309)
            .font(.sfCompactText(.regular, size: 18))
            .keyboardType(.default)
            .autocapitalization(.none)
            .onSubmit {
                withAnimation {
                    if !currentTag.isEmpty {
                        tags.append(currentTag)
                        currentTag = ""
                    }
                }
            }
        }
        .padding(.vertical, 20)
        .overlay(Rectangle()
            .strokeBorder(lineWidth: 0.2)
            .frame(height: 1)
            .padding(.top, 35))
        .foregroundColor(.black) // underlinetext
    }
}
