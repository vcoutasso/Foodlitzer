import SwiftUI

struct SoundBars: View {
    @ObservedObject private var mic = MicrophoneMonitor()

    var body: some View {
        VStack {
            HStack(spacing: 4) {
                ForEach(mic.soundSamples, id: \.self) { level in
                    BarView(value: mic.normalizeSoundLevel(level: level))
                }
            }
        }
    }
}

struct BarView: View {
    @ObservedObject private var mic = MicrophoneMonitor()
    var value: CGFloat

    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.black.opacity(0.8))
                .frame(width: (UIScreen.main.bounds.width - CGFloat(mic.numberOfSamples) * 4) /
                    CGFloat(mic.numberOfSamples),
                    height: value)
        }
    }
}
