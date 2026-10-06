//
//  AboutAppCard.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 02/10/26.
//

import SwiftUI

struct AboutAppCard: View {
    
    var iconCard: String = "info.circle"
    var aboutTitle: String = "Sobre nós"
    
    var body: some View {
        
        HStack(spacing: 16) {
            Image(systemName: iconCard)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.primary)
                .frame(height: 26)
            
            Text(aboutTitle)
                .foregroundStyle(.primary)
                .font(.headline)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 8)
        .padding(.vertical, 24)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(.background)
                .shadow(
                    color: .black.opacity(0.18),
                    radius: 6,
                    x: 0,
                    y: 4
                )
        }
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(.secondary.opacity(0.2), lineWidth: 1.5)
        }
    }
}


#Preview {
    AboutAppCard()
}

