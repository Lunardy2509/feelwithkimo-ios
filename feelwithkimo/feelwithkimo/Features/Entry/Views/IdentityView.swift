//
//  IdentityView.swift
//  
//
//  Created by Richard Sugiharto on 20/10/25.
//

import SwiftUI

struct IdentityView: View {
    @StateObject var viewModel: IdentityViewModel = IdentityViewModel()

    var body: some View {
        if viewModel.identity == "" {
            VStack(spacing: 24) {
                KimoHeaderView {
                    VStack(alignment: .center, spacing: 8) {
                        Text("Identitas Orang Tua")
                            .font(.app(.largeTitle, family: .primary))
                            .fontWeight(.bold)

                        Text("Yuk, isi sedikit data supaya Kimo bisa mengenal keluarga kecilmu!")
                            .font(.app(.title2, family: .primary))
                            .lineLimit(2)
                    }
                }
                
                Spacer()

                VStack(alignment: .center, spacing: 8) {
                    Text("Nama panggilan anak terhadap orang tua:")
                        .font(.app(.title2, family: .primary))
                        .fontWeight(.bold)
                    
                    KimoTextField(placeholder: "Example: Papa", inputText: $viewModel.nicknameInput)
                }
                .padding(.horizontal)
                
                Spacer()

                Button(action: {
                    viewModel.submitNickname()
                }, label: {
                    Text("Lanjut")
                        .font(.app(.body, family: .primary))
                        .bold()
                        .padding(.horizontal, 26)
                        .padding(.vertical, 14)
                        .frame(maxWidth: 150)
                        .background(ColorToken.backgroundMain.toColor())
                        .foregroundStyle(ColorToken.textPrimary.toColor())
                        .cornerRadius(12)
                        .padding(.vertical, 170)
                })
                .padding(.horizontal)
                .disabled(viewModel.nicknameInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .navigationDestination(isPresented: $viewModel.navigateToChild) {
                ChildIdentityView(viewModel: viewModel)
            }
            .onAppear {
                if !viewModel.parentNickname.isEmpty {
                    viewModel.nicknameInput = viewModel.parentNickname
                }
            }
            .navigationBarBackButtonHidden(true)
        } else {
            HomeView()
        }
    }
}
#Preview {
    IdentityView()
}
