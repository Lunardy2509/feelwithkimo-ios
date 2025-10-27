//
//  EntryView.swift
//
//  Created by Richard Sugiharto on 20/10/25.
//

import SwiftUI

struct EntryView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("Kimo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 330)
                    .padding(.bottom, 70)
                    .accessibilityHidden(true)

                Text("Hai, aku Kimo!")
                    .font(.app(.largeTitle, family: .primary))
                    .fontWeight(.bold)
                    .accessibilitySortPriority(1)

                Text("Yuk, bantu si kecil mengenal perasaan dengan cerita dan permainan seru")
                    .font(.app(.title2, family: .primary))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 0.5 * UIScreen.main.bounds.width)
                    .padding(.horizontal)
                    .padding(.bottom, 35)
                    .accessibilitySortPriority(2)

                NavigationLink {
                    IdentityView()
                } label: {
                    KimoButton(textLabel: "Ayo Mulai")
                }
            }
        }
    }
}
