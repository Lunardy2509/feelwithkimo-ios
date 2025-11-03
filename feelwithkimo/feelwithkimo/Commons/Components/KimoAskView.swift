//
//  TanyaKimoView.swift
//  feelwithkimo
//
//  Created by Ferdinand Lunardy on 03/11/25.
//

import SwiftUI

struct KimoAskView: View {
    var icon: String = "Kimo"
    var textField: String = "KimoAsk"
    var titleText: String = "Title"
    var bodyText: String = "Body"
    
    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            ZStack(alignment: .leading) {
                Image(textField)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 594.5, height: 130)
                    .padding()
                
                VStack {
                    Text(titleText)
                        .font(.app(.title2))
                    Text(bodyText)
                        .font(.app(.body))
                }
                .padding(.leading, 100)
            } 
        }
    }
}

#Preview {
    KimoAskView()
}
