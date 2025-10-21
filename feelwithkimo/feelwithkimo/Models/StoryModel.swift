//
//  StoryModel.swift
//  feelwithkimo
//
//  Created by Richard Sugiharto on 20/10/25.
//

import Foundation

struct StoryModel: Identifiable {
    let id: UUID
    let name: String
    let thumbnail: String
    let description: String
    var storyScene: [StorySceneModel]
}

class StorySceneModel {
    let path: String
    let text: String
    var isEnd: Bool
    var question: QuestionOption?
    var nextScene: [StorySceneModel]

    init(path: String, text: String, isEnd: Bool) {
        self.path = path
        self.text = text
        self.isEnd = isEnd
        self.question = nil
        self.nextScene = []
    }
}

struct QuestionOption {
    let question: String
    let option: [String]
}
