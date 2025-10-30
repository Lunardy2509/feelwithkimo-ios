//
//  BreathingViewMidfi.swift
//  feelwithkimo
//
//  Created by Ferdinand Lunardy on 30/10/25.
//
import SwiftUI

struct BreathingModuleView: View {
    @State private var currentPhase: BreathingPhase = .inhale
    @State private var animationScale: CGFloat = 1.0
    @State private var timer: Timer?
    @State private var remainingTime: Int = 4
    @State private var isActive = false
    
    var onCompletion: (() -> Void)?
    
    enum BreathingPhase: String, CaseIterable {
        case inhale = "Tarik Nafas"
        case hold = "Tahan Nafas"
        case exhale = "Hembuskan Nafas"
        
        var duration: TimeInterval {
            return 4.0 // 4 seconds for each phase
        }
        
        var scale: CGFloat {
            switch self {
            case .inhale:
                return 1.5
            case .hold:
                return 1.5
            case .exhale:
                return 1.0
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 40) {
            // Title
            Text("Tarik Nafas")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(ColorToken.textPrimary.toColor())
            
            // Breathing animation circle
            ZStack {
                Rectangle()
                    .fill(ColorToken.grayscale70.toColor())
                    .frame(width: 300, height: 300)
                    .cornerRadius(20)
                    .scaleEffect(animationScale)
                    .animation(.easeInOut(duration: currentPhase.duration), value: animationScale)
                
                VStack {
                    Text(currentPhase.rawValue)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(ColorToken.textPrimary.toColor())
                    
                    Text("\(remainingTime)")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(ColorToken.textPrimary.toColor())
                }
            }
            
            // Instruction text
            Text("Video Kimo tarik nafas\nbersama Ibunya")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(ColorToken.textSecondary.toColor())
            
            Spacer()
            
            // Start/Stop button
            Button(action: {
                if isActive {
                    stopBreathing()
                } else {
                    startBreathing()
                }
            }, label: {
                Text(isActive ? "Berhenti" : "Mulai")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(ColorToken.additionalColorsWhite.toColor())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ColorToken.corePrimary.toColor())
                    .cornerRadius(12)
            })
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
        .background(ColorToken.backgroundMain.toColor())
        .onDisappear {
            stopBreathing()
        }
    }
    
    private func startBreathing() {
        isActive = true
        currentPhase = .inhale
        remainingTime = 4
        animationScale = currentPhase.scale
        startTimer()
    }
    
    private func stopBreathing() {
        isActive = false
        timer?.invalidate()
        timer = nil
        animationScale = 1.0
        currentPhase = .inhale
        remainingTime = 4
    }
    
    private func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingTime > 1 {
                remainingTime -= 1
            } else {
                // Move to next phase
                switch currentPhase {
                case .inhale:
                    currentPhase = .hold
                case .hold:
                    currentPhase = .exhale
                case .exhale:
                    currentPhase = .inhale
                }
                
                remainingTime = 4
                animationScale = currentPhase.scale
            }
        }
    }
}

#Preview {
    BreathingModuleView(onCompletion: {
        print("Breathing exercise completed")
    })
}
