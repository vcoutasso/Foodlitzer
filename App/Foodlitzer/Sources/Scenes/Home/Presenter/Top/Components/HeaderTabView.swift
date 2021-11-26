//
//  HeaderTabView.swift
//  Foodlitzer
//
//  Created by Alessandra Souza da Silva on 24/11/21.
//

import SwiftUI

struct Tab {
    var title: String
}

struct HeaderTabView: View {
    @Binding var index: Int
    @Binding var offset: CGFloat
    var width = UIScreen.main.bounds.width
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack {
                Button {
                    self.index = 0
                    self.offset = self.width
                } label: {
                    VStack {
                        HStack {
                            Text("Home")
                                .font(.compact(.regular, size: 14))
                                .foregroundColor(self.index == 0 ? .black : Color.black.opacity(0.7))
                        }
                        Capsule()
                            .fill(self.index == 0 ? Color.black : Color.clear)
                            .frame(height: 2)
                    }
                }
                Button {
                    self.index = 1
                    self.offset = 0
                } label: {
                    VStack {
                        HStack {
                            Text("Restaurants")
                                .font(.compact(.regular, size: 14))
                                .foregroundColor(self.index == 1 ? .black : Color.black.opacity(0.7))
                        }
                        Capsule()
                            .fill(self.index == 1 ? Color.black : Color.clear)
                            .frame(height: 2)
                    }
                }
//                Button {
//                    self.index = 2
//                    self.offset = -self.width
//                } label: {
//                    VStack {
//                        HStack {
//                            Text("Saved")
//                                .font(.compact(.regular, size: 14))
//                                .foregroundColor(self.index == 2 ? .black : Color.black.opacity(0.7))
//                        }
//                        Capsule()
//                            .fill(self.index == 2 ? Color.black : Color.clear)
//                            .frame(height: 2)
//                    }
//                }
            }
        })
    }
}
