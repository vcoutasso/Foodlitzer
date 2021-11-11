//
//  Application.swift
//  Spider-Verse
//
//  Created by Vinícius Couto on 08/11/21.
//

import Firebase
import SwiftUI

@main
struct Application: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            // ContentView()
            // TestingPhotoPickerView()
            SignUpView(viewModel: SignUpViewModel())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
        -> Bool {
        FirebaseApp.configure()
        return true
    }
}
