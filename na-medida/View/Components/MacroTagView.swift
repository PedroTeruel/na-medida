//
//  MacroTagView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 02/10/26.
//

import SwiftUI

struct MacroTagView: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .fontWeight(.bold)
                .foregroundColor(color)

            Text(text)
                .fontWeight(.regular)
                .foregroundStyle(.primary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.background)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color.primary.opacity(0.08), lineWidth: 1)
        )
    }
}

#Preview {
    MacroTagView(icon: "person", text: "Lasanha", color: Color.blue)
}
