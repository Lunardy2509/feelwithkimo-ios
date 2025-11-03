//
//  TanyaKimoView.swift
//  feelwithkimo
//
//  Created by Ferdinand Lunardy on 03/11/25.
//

import SwiftUI

struct KimoDialogueView: View {
    var kimoImageSize: CGFloat = 500
    var textFieldWidth: CGFloat = 500
    var textFieldHeight: CGFloat = 500
    var textFieldString: String = "Wihh ternyata begitu ekspresi marah.."
    
    var body: some View {
        ZStack {
            ColorToken.backgroundCard.toColor().opacity(0.7)
            HStack {
                Image("KimoTutorialAsset")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kimoImageSize, height: kimoImageSize)
                
                VStack {
                    Image("Rectangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: textFieldWidth, height: textFieldHeight)
                    
                    Image("Triangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: textFieldWidth, height: textFieldHeight)
                }
//                Text(textFieldString)
//                    .font(.app(.title3, family: .primary))
//                    .fontWeight(.regular)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    KimoDialogueView()
}
