//
//  ClapGameView.swift
//  feelwithkimo
//
//  Created by jonathan calvin sutrisna on 21/10/25.
//

import AVFoundation
import Combine
import SwiftUI

struct ClapGameView: View {
    // Cukup satu StateObject untuk ViewModel
    @StateObject var viewModel: ClapGameViewModel

    var onCompletion: (() -> Void)?

    init(onCompletion: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: ClapGameViewModel(onCompletion: onCompletion))
    }

    var body: some View {
        VStack {
            // MARK: - Header
            headerView

            // MARK: - Progress Bar
            ProgressBarView(currentStep: viewModel.beatCount)

            // MARK: - Content
            cameraContentView
        }
        .padding(40)
    }
}
