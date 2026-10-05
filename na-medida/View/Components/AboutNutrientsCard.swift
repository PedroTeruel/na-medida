//
//  AboutNutrientsCard.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 02/10/26.
//

import SwiftUI

struct AboutNutrientsCard: View {
    var cardTitle: String = "Definição dos nutrientes"
    var cardBody: String = "Entenda melhor sobre os ingredientes das suas receitas"
    var cardImg: String = "book"
    
    var body: some View {
        
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                
                Text(cardTitle)
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)

                Text(cardBody)
                    .fontWeight(.regular)
                    .foregroundStyle(.secondary)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)

            }
            Spacer()

            Image(cardImg)
                .resizable()
                .scaledToFit()
                .frame(height: 70)
        }
        .padding()
        .frame(maxWidth: .infinity)
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
                .stroke(.gray.opacity(0.5), lineWidth: 1)
        }
    }
}

#Preview {
    AboutNutrientsCard()
}
