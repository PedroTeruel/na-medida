//
//  AboutAppCard.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 02/10/26.
//

import SwiftUI

struct AboutAppCard: View {
    
    var iconCard: String = "info.circle"
    var aboutTitle: String = "Termos de uso"
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: iconCard)
                .resizable()
                .scaledToFit()
                .frame(height: 26)
            Text(aboutTitle)
                .font(.headline)
        }
        .frame(width: 160)
        .padding(.horizontal, 10)
        .padding(.vertical, 22)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(.white)
                .shadow(
                    color: .black.opacity(0.18),
                    radius: 6,
                    x: 0,
                    y: 4
                )
        }
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(.gray.opacity(0.5), lineWidth: 1)
        }
    }
}

#Preview {
    AboutAppCard()
}
