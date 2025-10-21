//
//  AudioManager.swift
//  Kimo
//
//  Created by Aristo Yongka on 12/10/25.
//

import AVFoundation
import UIKit   // diperlukan untuk NSDataAsset

final class AudioManager {
    static let shared = AudioManager()
    private var player: AVAudioPlayer?

    private init() {}

    /// Coba mainkan musik dengan 3 strategi:
    /// 1) Cari file "backsong.mp3" di bundle (kalau ternyata ada),
    /// 2) Cari file "backsong" TANPA ekstensi di bundle,
    /// 3) Ambil dari Assets.xcassets sebagai Data Asset bernama "backsong".
    func startBackgroundMusic(assetName: String = "backsong") {
        if let audioPlayer = player, audioPlayer.isPlaying { return }

        // 1) URL dengan ekstensi mp3
        if let url = Bundle.main.url(forResource: assetName, withExtension: "mp3") {
            startFromURL(url)
            return
        }

        // 2) URL tanpa ekstensi
        if let urlNoExt = Bundle.main.url(forResource: assetName, withExtension: nil) {
            startFromURL(urlNoExt)
            return
        }

        // 3) Data Asset dari Assets.xcassets (nama "backsong")
        if let dataAsset = NSDataAsset(name: assetName) {
            startFromData(dataAsset.data, fileTypeHint: AVFileType.mp3.rawValue)
            return
        }

        // Jika semua gagal, beri log jelas
        assertionFailure("Audio '\(assetName)' tidak ditemukan sebagai file (.mp3 / tanpa ekstensi) atau Data Asset.")
    }

    private func startFromURL(_ url: URL) {
        do {
            try configureSession()
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.numberOfLoops = -1
            audioPlayer.volume = 1.0
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            self.player = audioPlayer
            print("🎵 Start music from URL: \(url.lastPathComponent)")
        } catch {
            assertionFailure("Audio error (URL): \(error.localizedDescription)")
        }
    }

    private func startFromData(_ data: Data, fileTypeHint: String? = AVFileType.mp3.rawValue) {
        do {
            try configureSession()
            let audioPlayer = try AVAudioPlayer(data: data, fileTypeHint: fileTypeHint)
            audioPlayer.numberOfLoops = -1
            audioPlayer.volume = 1.0
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            self.player = audioPlayer
            print("🎵 Start music from Data Asset")
        } catch {
            assertionFailure("Audio error (Data): \(error.localizedDescription)")
        }
    }

    private func configureSession() throws {
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.playback, mode: .default, options: [])
        try session.setActive(true)
    }

    func stop() {
        player?.stop()
        player = nil
        try? AVAudioSession.sharedInstance().setActive(false)
    }
}
