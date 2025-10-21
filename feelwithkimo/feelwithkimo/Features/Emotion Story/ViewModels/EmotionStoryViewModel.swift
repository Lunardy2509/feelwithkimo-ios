//
//  EmotionStoryViewModel.swift
//  feelwithkimo
//
//  Created by Richard Sugiharto on 20/10/25.
//

import Foundation

class EmotionStoryViewModel: ObservableObject {
    var emotion: EmotionModel

    init (emotion: EmotionModel) {
        self.emotion = emotion
        fetchStory()
    }

    private func fetchStory() {
        for number in 1...3 {
            emotion.stories.append(StoryModel(
                id: UUID(),
                name: "Story \(number)",
                thumbnail: "thumbnail \(number)",
                description: "Deskripsi \(number)",
                storyScene: [])
            )
        }
    }
}
