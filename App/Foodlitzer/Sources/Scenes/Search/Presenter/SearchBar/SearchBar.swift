import SwiftUI

struct SearchBar: View {
    // MARK: - Binding Atributes

    @Binding var query: String
    @Binding var showCancelButton: Bool

    // MARK: - View

    var body: some View {
        HStack {
            searchField

            if showCancelButton { cancelButton }
        }
        .navigationBarHidden(showCancelButton)
    }

    // MARK: - Extracted Views

    private var searchField: some View {
        TextField(Localizable.Search.Placeholder.text, text: $query, onEditingChanged: { _ in
            withAnimation { self.showCancelButton = true }
        })
        .keyboardType(.default)
        .padding(.leading, 40)
        .padding(.trailing, 35)
        .font(.compact(.light, size: 14))
        .frame(height: 35)
        .customStroke()
        .overlay(clearFieldButton)
        .animation(.default, value: query)
    }

    private var clearFieldButton: some View {
        HStack {
            Image(systemName: Strings.Symbols.search)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(10)

            if showCancelButton {
                Button {
                    self.query = ""
                } label: {
                    Image(systemName: Strings.Symbols.xmark)
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(.black).opacity(query.isEmpty ? 0 : 1)
                        .padding(.trailing, 8)
                }
            }
        }
    }

    private var cancelButton: some View {
        Button("Cancelar") { // TODO: Quando pressionado volta para a tela anterior, dissmiss da view de search.
            withAnimation {
                hideKeyboard() // TODO: Quando scrollar, dar dissmiss no keyboard
                self.query = ""
                self.showCancelButton = false
            }
        }
        .font(.system(size: 11, weight: .medium, design: .default))
        .foregroundColor(Color.black)
        .transition(.move(edge: .trailing))
        .animation(.default, value: query)
        .padding(.horizontal, 20)
    }
}