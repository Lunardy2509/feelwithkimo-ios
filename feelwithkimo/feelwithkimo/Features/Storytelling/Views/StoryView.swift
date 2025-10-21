//
//  StoryView.swift
//  feelwithkimo
//
//  Created by Richard Sugiharto on 20/10/25.
//

import SwiftUI

struct StoryView: View {
    @StateObject var viewModel: StoryViewModel = StoryViewModel()

    var body: some View {
        ZStack {
            Image(viewModel.story.storyScene[viewModel.index].path)
                .resizable()
                .frame(maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
                .id(viewModel.index)
                .modifier(FadeContentTransition())
                .animation(.easeInOut(duration: 1.5), value: viewModel.index)

            // Area tombol transparan kiri/kanan
            GeometryReader { geo in
                HStack(spacing: 0) {
                    Button {
                        viewModel.goScene(to: -1)
                    } label: {
                        Color.clear.contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .frame(width: geo.size.width/2, height: geo.size.height)
                    .accessibilityLabel("Previous")

                    Button {
                        viewModel.goScene(to: 1)
                    } label: {
                        Color.clear.contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .frame(width: geo.size.width/2, height: geo.size.height)
                    .accessibilityLabel("Next")
                }
                .ignoresSafeArea()
            }
        }
        .onAppear { AudioManager.shared.startBackgroundMusic() }
        .onDisappear { AudioManager.shared.stop() }
        .statusBarHidden(true)
    }
}

// Helper aman akses index
fileprivate extension Array {
    subscript(safe idx: Int) -> Element? { indices.contains(idx) ? self[idx] : nil }
}

/// Modifier fade crossfade
struct FadeContentTransition: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content.contentTransition(.opacity)
        } else {
            content.transition(.opacity)
        }
    }
}
