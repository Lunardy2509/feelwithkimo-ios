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

struct StorySceneModel {
    let path: String
    let text: String
}
