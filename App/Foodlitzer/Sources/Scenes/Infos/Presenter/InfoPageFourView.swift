//
//  InfoPageFourView.swift
//  Foodlitzer
//
//  Created by Bruna Naomi Yamanaka Silva on 25/11/21.
//

import SwiftUI

struct InfoPageFourView: View {
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            ZStack {
                Text("This restaurant has been reviewed 102 times by Foodlitzer's users. What would you like to do now?")
                    .modifier(FontePadrao())
                    .padding()
                    .frame(width: 331, height: 126)

                HStack {
                    Button("Save") {}
                        .modifier(ButtonAction())
                    NavigationLink {
                        NewReviewView(viewModel: NewReviewViewModelFactory.make())
                    } label: {
                        Text("New review")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(.white)
                            .padding(.vertical, 7)
                            .frame(width: 142)
                            .background(Color(.black))
                    }
                }
                .padding(.top, 120)
            }

        }.padding(.vertical, 90)
    }
}

#if DEBUG
    struct InfoPageFourView_Previews: PreviewProvider {
        static var previews: some View {
            InfoPageFourView()
        }
    }
#endif
