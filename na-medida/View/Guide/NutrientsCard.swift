//
//  NutrientsCard.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 08/10/26.
//

import SwiftUI

struct NutrientsCard: View {
    var nutrientName: String = "Gorduras Totais"
    var nutrientDescription: String = "Energia, hormônios e absorção de vitaminas"
    var nutrientImg: String = "book"
    
    var body: some View {
        
        HStack(spacing: 12) {
            Image(nutrientImg)
                .resizable()
                .scaledToFit()
                .frame(height: 70)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(nutrientName)
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(nutrientDescription)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundStyle(.secondary)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
            Image(systemName: "chevron.forward")
                .foregroundStyle(.secondary)
                .padding(.trailing, 10)
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(.background)
                .shadow(
                    color: .black.opacity(0.1),
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
    NutrientsCard()
}
