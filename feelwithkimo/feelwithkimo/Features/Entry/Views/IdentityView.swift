//
//  IdentityView.swift
//  
//
//  Created by Richard Sugiharto on 20/10/25.
//

import SwiftUI

struct IdentityView: View {
    @AppStorage("identity") var identity = ""
    @StateObject var viewModel: IdentityViewModel = IdentityViewModel()

    var body: some View {
        if identity == "" {
            VStack(spacing: 24) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                        .shadow(radius: 4)

                    VStack(alignment: .center, spacing: 8) {
                        Text("Identitas Orang Tua")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Yuk, isi sedikit data supaya Kimo bisa mengenal keluarga kecilmu!")
                            .font(.title2)
                            .lineLimit(2)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 48)
                }
                .frame(height: 140)

                VStack(alignment: .center, spacing: 8) {
                    Text("Nama panggilan anak terhadap orang tua:")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    KimoTextField(placeholder: "Example: Papa", inputText: $viewModel.nicknameInput)
                }
                .padding(.horizontal)
                .padding(.top, 175)

                KimoButton(textLabel: "Lanjut")
                    .onTapGesture {
                        viewModel.submitNickname()
                    }
                    .padding(.top, 168)

                Spacer()
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
