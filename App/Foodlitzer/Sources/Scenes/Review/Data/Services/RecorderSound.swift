import AVFoundation
import Foundation

class MicrophoneMonitor: ObservableObject {
    // MARK: Atributes

    private var audioRecorder: AVAudioRecorder
    private var timer: Timer?

    private var currentSample: Int
    var numberOfSamples: Int = 75

    @Published public var soundSamples: [Float]

    init() {
        self.soundSamples = [Float](repeating: .zero, count: numberOfSamples)
        self.currentSample = 0

        // MARK: Permissão do microfone

        let audioSession = AVAudioSession.sharedInstance()
        if audioSession.recordPermission != .granted {
            audioSession.requestRecordPermission { isGranted in
                if !isGranted {
                    fatalError("Libere o audio")
                }
            }
        }

        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)
        let recorderSettings: [String: Any] = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
        ]

        do {
            self.audioRecorder = try AVAudioRecorder(url: url, settings: recorderSettings)
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 100) / 2
        return CGFloat(level * (300 / 50))
    }

    func startMonitoring() {
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.audioRecorder.updateMeters()
            self.soundSamples[self.currentSample] = self.audioRecorder.averagePower(forChannel: 0)
            self.currentSample = (self.currentSample + 1)
            if self.currentSample == self.numberOfSamples {
                self.audioRecorder.stop()
                self.timer?.invalidate()
            }
        })
    }

    deinit {
        timer?.invalidate()
        audioRecorder.stop()
    }
    // TO-DO: passar pelas 75 amostras e mostra a média
}
