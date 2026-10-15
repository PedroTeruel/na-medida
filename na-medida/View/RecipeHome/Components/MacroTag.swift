//
//  MacroTagView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 02/10/26.
//

import SwiftUI

struct MacroTag: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .resizable()
                .scaledToFill()
                .frame(width: 10, height: 10)
                .foregroundColor(color)
            
            Text(text)
                .font(.callout)
                .fontWeight(.regular)
                .foregroundStyle(.primary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(.background)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color.primary.opacity(0.08), lineWidth: 1)
        )
    }
}

#Preview {
    MacroTag(icon: "leaf.fill", text: "Lasanha", color: .blue)
}
