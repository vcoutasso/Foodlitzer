//
//  ProfileView.swift
//  Spider-Verse
//
//  Created by Eros Maurilio on 13/11/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var sessionService: SessionServiceUseCase

    var body: some View {
        VStack {
            Text("Name: \(sessionService.userDetails?.name ?? "N/A")")
                .padding()
            Text("Email: \(sessionService.userDetails?.email ?? "N/A")")
                .padding()

            Button {
                sessionService.logOut()

            } label: {
                Text("Logout")
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
            }
            .padding(.vertical, 16)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(SessionServiceUseCase())
    }
}
