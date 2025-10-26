//
//  AudioLevelBreathDetector.swift
//  feelwithkimo
//
//  Created by Ferdinand Lunardy on 21/10/25.
//

import AVFoundation
import Combine
import Foundation

internal class AudioLevelBreathDetector: ObservableObject {
    @Published var audioLevel: Double = 0.0
    @Published var isBreathing: Bool = false
    @Published var breathType: BreathType = .none
    private let audioEngine = AVAudioEngine()
    private var audioLevelTimer: Timer?
    private var previousLevel: Double = 0.0
    private let breathThreshold: Double = 0.015
    private let changeThreshold: Double = 0.015
    func startDetection() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.record, mode: .measurement, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            let inputNode = audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                self.processAudioBuffer(buffer)
            }
            try audioEngine.start()
        } catch {
            print("Failed to start audio detection: \(error)")
        }
    }
    func stopDetection() {
        // Stop the audio engine safely
        if audioEngine.isRunning {
            audioEngine.stop()
        }
        
        // Remove audio tap safely
        audioEngine.inputNode.removeTap(onBus: 0)
        
        // Invalidate timer
        audioLevelTimer?.invalidate()
        audioLevelTimer = nil
        
        // Reset state on main queue
        DispatchQueue.main.async {
            self.audioLevel = 0.0
            self.isBreathing = false
            self.breathType = .none
        }
        
        // Deactivate audio session to prevent pipe errors
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
    private func processAudioBuffer(_ buffer: AVAudioPCMBuffer) {
        guard let channelData = buffer.floatChannelData?[0] else { return }
        let channelDataArray = Array(UnsafeBufferPointer(start: channelData, count: Int(buffer.frameLength)))
        // Calculate RMS (Root Mean Square) for audio level
        let rms = sqrt(channelDataArray.map { $0 * $0 }.reduce(0, +) / Float(channelDataArray.count))
        let level = Double(rms)
        DispatchQueue.main.async {
            self.audioLevel = level
            self.detectBreathPattern(level: level)
        }
    }
    private func detectBreathPattern(level: Double) {
        let levelChange = level - previousLevel
        if level > breathThreshold {
            isBreathing = true
            if levelChange > changeThreshold {
                breathType = .inhale
            } else if levelChange < -changeThreshold {
                breathType = .exhale
            }
        } else {
            isBreathing = false
            breathType = .none
        }
        previousLevel = level
    }
}
