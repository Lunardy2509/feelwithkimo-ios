//
//  EmotionStoryView.swift
//  feelwithkimo
//
//  Created by Richard Sugiharto on 20/10/25.
//

import SwiftUI

struct EmotionStoryView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: EmotionStoryViewModel
    @ObservedObject private var audioManager = AudioManager.shared
    
    var body: some View {
        HStack(spacing: 37) {
            ZStack {
                VStack(alignment: .center) {
                    HStack {
                        KimoBackButton()
                            .onTapGesture {
                                audioManager.stop()
                                dismiss()
                            }
                        
                        Spacer()
                    }
                    .padding(.top, 35)

                    Spacer().frame(height: 115)

                    Image(viewModel.emotion.emotionImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 186, height: 186)
                        .clipShape(Circle())
                        .shadow(radius: 10)

                    Text(viewModel.emotion.title)
                        .font(.app(.largeTitle, family: .primary))
                        .fontWeight(.bold)
                        .foregroundStyle(ColorToken.textPrimary.toColor())

                    Text(viewModel.emotion.description)
                        .font(.app(.title2, family: .primary))
                        .foregroundStyle(ColorToken.textSecondary.toColor())
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.horizontal, 35)
            }
            .frame(maxWidth: 0.4 * UIScreen.main.bounds.width)
            .background(ColorToken.backgroundMain.toColor())

            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    ForEach(viewModel.emotion.stories) { story in
                        NavigationLink {
                            StoryView()
                        } label: {
                            HStack {
                                Image("Thumbnail")

                                VStack(alignment: .leading) {
                                    Text(story.name)
                                        .font(.app(.title2, family: .primary))
                                        .fontWeight(.bold)

                                    Text(story.description)
                                        .font(.app(.body, family: .primary))

                                }
                            }
                            .foregroundStyle(ColorToken.additionalColorsBlack.toColor())
                        }

                        Divider()
                    }
                }
            }
            .frame(maxWidth: 0.6 * UIScreen.main.bounds.width)
            .padding(.top, 115)
            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}
