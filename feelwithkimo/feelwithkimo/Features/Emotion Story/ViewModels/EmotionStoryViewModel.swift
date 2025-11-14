//
//  EmotionStoryViewModel.swift
//  feelwithkimo
//
//  Created by Richard Sugiharto on 20/10/25.
//

import Foundation

internal class EmotionStoryViewModel: ObservableObject {
    @Published var emotion: EmotionModel

    init (emotion: EmotionModel) {
        self.emotion = emotion
        fetchStory(story: emotion.id)
    }

    private func fetchStory(story storyPath: String) {
        guard let url = Bundle.main.url(forResource: storyPath, withExtension: "json") else {
            print("❌ \(storyPath).json not found in bundle")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            self.emotion = try decoder.decode(EmotionModel.self, from: data)
            
        } catch {
            print("❌ Failed to load story.json:", error)
        }
    }
}
