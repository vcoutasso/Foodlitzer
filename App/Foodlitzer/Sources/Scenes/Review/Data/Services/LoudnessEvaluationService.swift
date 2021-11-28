import AVFoundation
import Combine

protocol LoudnessEvaluationServiceProtocol: ObservableObject {
    var isPermissionGranted: Bool { get }
    var normalizedSoundLevels: [SoundSampleInfo] { get }
    var numberOfSamples: Int { get }
    func setup()
    func execute(afterTimeInterval: @escaping () -> Void, completion: @escaping () -> Void)
}

final class LoudnessEvaluationService: LoudnessEvaluationServiceProtocol {
    // MARK: Properties

    @Published private(set) var soundSamples: [SoundSampleInfo]

    private(set) var numberOfSamples: Int
    private var audioRecorder: AVAudioRecorder
    private let audioSession: AVAudioSession
    private var currentSample: Int
    private var timer: Timer?

    // MARK: - Computed variables

    var isPermissionGranted: Bool {
        if audioSession.recordPermission == .granted {
            return true
        } else {
            debugPrint("Audio record permission not granted or undetermined")
            return false
        }
    }

    var normalizedSoundLevels: [SoundSampleInfo] {
        soundSamples.map { .init(level: normalizeSoundLevel($0.level)) }
    }

    private var shouldInterruptRecording: Bool {
        currentSample == numberOfSamples
    }

    // MARK: - Object lifecycle

    init?(numberOfSamples: Int = 65) {
        self.numberOfSamples = numberOfSamples
        self.soundSamples = .init(repeating: .init(level: .zero), count: numberOfSamples)
        self.audioSession = .sharedInstance()
        self.currentSample = 0

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
            debugPrint("Could not set audio recorder and/or audio session: \(error.localizedDescription)")
            return nil
        }
    }

    deinit {
        stopTimerAndRecorder()
    }

    // MARK: Setup

    func setup() {
        audioSession.requestRecordPermission { isGranted in
            debugPrint("Permission granted: \(isGranted)")
        }
    }

    // MARK: - Execute

    func execute(afterTimeInterval: @escaping () -> Void, completion: @escaping () -> Void) {
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()
        currentSample = 0

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }

            self.setCurrentReading()
            afterTimeInterval()

            if self.shouldInterruptRecording {
                self.stopTimerAndRecorder()
                completion()
            }
        })
    }

    // MARK: - Helper methods

    private func setCurrentReading() {
        audioRecorder.updateMeters()
        soundSamples[currentSample] = .init(level: audioRecorder.averagePower(forChannel: 0))
        currentSample += 1
    }

    private func stopTimerAndRecorder() {
        timer?.invalidate()
        audioRecorder.stop()
    }

    private func normalizeSoundLevel(_ level: Float) -> Float {
        max(0.2, level + 50)
    }
}
