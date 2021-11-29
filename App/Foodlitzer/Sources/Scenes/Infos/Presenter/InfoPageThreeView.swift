import SwiftUI

struct InfoPageThreeView: View {
    @State private var showAlert = false

    let imagens: [Image]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                ForEach(imagens.indices, id: \.self) { index in
                    imagens[index]
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 70, height: 400)
                        .padding(.bottom, 10)
                }
            }
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}

#if DEBUG
    struct InfoPageThreeView_Previews: PreviewProvider {
        static var previews: some View {
            InfoPageThreeView(imagens: [])
                .ignoresSafeArea()
                .background(.gray)
        }
    }
#endif
