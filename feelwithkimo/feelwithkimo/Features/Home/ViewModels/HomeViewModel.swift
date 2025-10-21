//
//  HomeViewModel.swift
//  feelwithkimo
//
//  Created by jonathan calvin sutrisna on 19/10/25.
//

import Combine
import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @AppStorage("identity") var identity: String = ""

    // MARK: - Published Properties
    @Published var currentUser: UserModel?
    @Published var emotions: [EmotionModel] = []
    @Published var selectedEmotion: EmotionModel?

    // MARK: - Lifecycle
    init() {
        fetchData()
    }

    // MARK: - Private Methods

    /// Mengambil semua data yang diperlukan untuk Home View.
    /// Fungsi ini memanggil manager untuk mendapatkan data user dan menyiapkan daftar emosi.
    private func fetchData() {
//        self.currentUser = UserManager.shared.getCurrentUser()
        self.currentUser = UserModel(id: UUID(), name: identity)

        // Data dummy untuk daftar emosi
        self.emotions = [
            EmotionModel(id: UUID(), name: "Seneng", visualCharacterName: "face.smiling", stories: []),
            EmotionModel(id: UUID(), name: "Marah", visualCharacterName: "face.dashed", stories: []),
            EmotionModel(id: UUID(), name: "Sedih", visualCharacterName: "face.rolling.eyes", stories: []),
            EmotionModel(id: UUID(), name: "Kaget", visualCharacterName: "figure.mind.and.body", stories: []),
            EmotionModel(id: UUID(), name: "Takut", visualCharacterName: "figure.walk.motion", stories: []),
            EmotionModel(id: UUID(), name: "Marah", visualCharacterName: "face.dashed", stories: []),
            EmotionModel(id: UUID(), name: "Sedih", visualCharacterName: "face.rolling.eyes", stories: []),
            EmotionModel(id: UUID(), name: "Kaget", visualCharacterName: "figure.mind.and.body", stories: []),
            EmotionModel(id: UUID(), name: "Takut", visualCharacterName: "figure.walk.motion", stories: []),
            EmotionModel(id: UUID(), name: "Marah", visualCharacterName: "face.dashed", stories: []),
            EmotionModel(id: UUID(), name: "Sedih", visualCharacterName: "face.rolling.eyes", stories: []),
            EmotionModel(id: UUID(), name: "Kaget", visualCharacterName: "figure.mind.and.body", stories: []),
            EmotionModel(id: UUID(), name: "Takut", visualCharacterName: "figure.walk.motion", stories: [])
        ]

        self.selectedEmotion = emotions.first(where: { $0.name == "Sedih" })
    }

    // MARK: - Public Methods

    /// Mengatur emosi yang dipilih oleh pengguna.
    /// Dipanggil dari View ketika pengguna mengetuk salah satu kartu emosi.
    /// - Parameter emotion: Emosi yang dipilih.
    func selectEmotion(_ emotion: EmotionModel) {
        selectedEmotion = emotion
    }
}
