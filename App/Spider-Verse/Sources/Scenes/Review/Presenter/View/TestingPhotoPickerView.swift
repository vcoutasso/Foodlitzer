//
//  TestingPhotoPickerView.swift
//  Spider-Verse
//
//  Created by Vinícius Couto on 10/11/21.
//

import SwiftUI

struct TestingPhotoPickerView: View {
    @State private var isShowingPhotoPicker = false
    @State private var image = UIImage(systemName: "person.fill")!

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(Circle())
                .padding()
                .onTapGesture { isShowingPhotoPicker.toggle() }

            Spacer()
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPickerRepresentable(selectedImage: $image)
        }
    }
}
