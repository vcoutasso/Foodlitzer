import AVFoundation
import SwiftUI

struct TestingRecorderSoundView: View {
    @ObservedObject private var mic = MicrophoneMonitor()
    let numberOfSamples: Int = 75

    var body: some View {
        VStack {
            Button("Record") {
                mic.startMonitoring()
            }
        }
    }
}

struct TestingRecorderSoundView_Previews: PreviewProvider {
    static var previews: some View {
        TestingRecorderSoundView()
    }
}
