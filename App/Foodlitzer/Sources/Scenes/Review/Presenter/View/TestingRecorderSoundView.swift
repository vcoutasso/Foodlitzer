import AVFoundation
import SwiftUI

struct TestingRecorderSoundView: View {
    @ObservedObject private var mic = MicrophoneMonitor()
    @State private var isButtonActive: Bool = true
    let numberOfSamples: Int = 65

    var body: some View {
        VStack {
            HStack(spacing: 2.8){
                ForEach(mic.soundSamples, id: \.self) { level in
                    BarView(value: mic.normalizeSoundLevel(level: level))
                }
            }
            Button("Record") {
                mic.startMonitoring()
                isButtonActive = false
            }.disabled(isButtonActive == false)
        }
    }
}

struct BarView: View{
    var value: CGFloat
    var body: some View{
        VStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black)
                .frame(width: 1.8, height: value)
        }
        
    }
}

struct TestingRecorderSoundView_Previews: PreviewProvider {
    static var previews: some View {
        TestingRecorderSoundView()
    }
}
