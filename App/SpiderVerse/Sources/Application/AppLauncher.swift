import SwiftUI

@main
enum AppLauncher {
    static func main() throws {
        if NSClassFromString("XCTest") == nil {
            Application.main()
        } else {
            TestApp.main()
        }
    }
}

struct TestApp: App {
    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}
