//
//  EmotionStoryViewModel.swift
//  feelwithkimo
//
//  Created by Richard Sugiharto on 20/10/25.
//

import Foundation

internal class EmotionStoryViewModel: ObservableObject {
    @Published var emotion: EmotionModel = EmotionModel(
        id: "",
        title: "",
        description: "",
        image: "",
        stories: []
    )

    init(emotion: EmotionModel? = nil, path: String) {
        self.fetchStory(story: path)
    }

    /// Load story scene
    private func fetchStory(story storyPath: String) {
        let languageCode = Locale.current.language.languageCode?.identifier ?? "en"
        let scriptCode = Locale.current.language.script?.identifier
        
        var localizedSuffix = "_en"
        
        if languageCode == "id" {
            localizedSuffix = "_id"
        } else if languageCode == "zh" {
            // Use "Hant" (Capitalized) to match iOS system standard
            if scriptCode == "Hant" {
                localizedSuffix = "_zh_hant"
            } else {
                localizedSuffix = "_zh_hans"
            }
        }
        
        // --- FALLBACK LOGIC START ---
        
        // 1. Try the specific localized path (e.g., "Balok_zh_hans")
        var finalPath = "\(storyPath)\(localizedSuffix)"
        var url = Bundle.main.url(forResource: finalPath, withExtension: "json")
        
        // 2. If not found, try English (e.g., "Balok_en")
        if url == nil {
            print("⚠️ \(finalPath) not found. Trying English...")
            finalPath = "\(storyPath)_en"
            url = Bundle.main.url(forResource: finalPath, withExtension: "json")
        }
        
        // 3. If STILL not found, try the Original Filename (e.g., "Balok")
        // This fixes the crash if you haven't renamed your main file yet.
        if url == nil {
            print("⚠️ \(finalPath) not found. Trying original file: \(storyPath)...")
            finalPath = storyPath
            url = Bundle.main.url(forResource: finalPath, withExtension: "json")
        }
        
        // --- FALLBACK LOGIC END ---

        guard let validUrl = url else {
            print("❌ CRITICAL: Could not find any version of \(storyPath). App will crash.")
            return
        }

        do {
            let data = try Data(contentsOf: validUrl)
            let decoder = JSONDecoder()
            self.emotion = try decoder.decode(EmotionModel.self, from: data)
            print("✅ Successfully loaded: \(validUrl.lastPathComponent)")
        } catch {
            print("❌ Failed to decode \(validUrl.lastPathComponent):", error)
        }
    }
}
