//
//  KimoTextField.swift
//  feelwithkimo
//
//  Created by Richard Sugiharto on 25/10/25.
//

import SwiftUI

struct KimoTextField: View {
    var placeholder: String
    @Binding var inputText: String
    
    var body: some View {
        TextField(placeholder, text: $inputText)
            .padding(.horizontal, 20)
            .padding(.vertical, 28)
            .background(
                RoundedRectangle(cornerRadius: 50).fill(ColorToken.grayscale30.toColor())
            )
            .submitLabel(.done)
            .kimoAccessibility(
                label: "Kolom teks",
                hint: "Ketuk dua kali untuk mulai mengetik. Placeholder: \(placeholder)",
                traits: .isSearchField,
                identifier: "kimoTextField.\(placeholder.lowercased().replacingOccurrences(of: " ", with: ""))"
            )
    }
}
