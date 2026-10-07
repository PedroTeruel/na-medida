//
//  ThreeTable.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 02/10/26.
//

import SwiftUI

struct ThreeTable: View {
    
    var body: some View {
        VStack(spacing: 22) {
            HStack(){
                Image(systemName: "info.circle.fill")
                    .foregroundStyle(.blue)
                VStack(alignment:.leading){
                    Text("Medidas de Sólidos")
                        .font(.headline)
                    Text("Veja a equivalencia entre gramas e as medidas caseiras mais comuns")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            HStack(spacing: 26) {
                Text("Ingrediente")
                Spacer()
                Text("1 Xícara de chá")
                Text("1 Colher de Sopa")
            }
            .font(.footnote)
            .foregroundStyle(.primary.opacity(0.8))
            .fontWeight(.regular)
            .padding(.vertical, 16)
            .padding(.horizontal, 6)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.blue.opacity(0.1))
            }
        }
        .frame(maxWidth: .infinity)
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
                .stroke(.secondary.opacity(0.2), lineWidth: 1.5)
        }
    }
}

#Preview {
    ThreeTable()
}
