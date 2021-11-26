import SwiftUI

struct SoundBars: View {
    @ObservedObject private var mic = MicrophoneMonitor()

    var body: some View {
        VStack {
            HStack(spacing: 4) {
                ForEach(mic.soundSamples, id: \.self) { level in
                    //Bar2View(value: mic.normalizeSoundLevel(level: level))
                }
            }
        }
    }
}

