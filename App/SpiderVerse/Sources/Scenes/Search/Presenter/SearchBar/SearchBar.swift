import SwiftUI

struct SearchBar: View {
    @Binding var query: String
    @Binding var showCancelButton: Bool

    var body: some View {
        VStack {
            HStack {
                TextField("Buscar Competição", text: $query, onEditingChanged: { _ in
                    withAnimation {
                        self.showCancelButton = true
                    }
                })
                .keyboardType(.default)
                .padding(.leading, 40)
                .padding(.trailing, 35)
                .font(.system(size: 14, weight: .regular, design: .default))
                .frame(height: 35)
                .background(Color.white)
                .border(Color.black, width: 0.3)
                .overlay(HStack {
                    Image(systemName: "magnifyingglass")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(10)

                    if showCancelButton {
                        Button(action: {
                            self.query = ""

                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .foregroundColor(.black).opacity(query == "" ? 0 : 1)
                                .padding(.trailing, 8)
                                .transition(.move(edge: .trailing))
                        }
                    }
                })
                .animation(.default, value: query)

                if showCancelButton {
                    Button("Cancelar") {
                        withAnimation {
                            hideKeyboard()
                            self.query = ""
                            self.showCancelButton = false
                        }
                    }
                    .font(.system(size: 11, weight: .medium, design: .default))
                    .foregroundColor(Color.black)
                    .transition(.move(edge: .trailing))
                    .animation(.default, value: query)
                    .padding(.horizontal, 10)
                }
            }
            .navigationBarHidden(showCancelButton)
        }
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(query: .constant(""), showCancelButton: .constant(false))
    }
}
