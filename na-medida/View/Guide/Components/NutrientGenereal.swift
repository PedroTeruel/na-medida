//
//  NutrientGenereal.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 08/10/26.
//

import SwiftUI

struct NutrientGenereal: View {
    var generalBody: String = "As gorduras (lipídios) são um grupo de nutrientes que fornecem energia, participam da produção de hormônios e ajudam na absorção de vitaminas lipossolúveis (A, D, E e K)."
    var generalCap:String
    var generalColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 26){
            VStack(alignment: .leading, spacing: 8){
                Text("O que são?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                Text(generalBody)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundStyle(.secondary)
                HStack(spacing: 22) {
                    Image(systemName: "lightbulb.max.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            .yellow,
                            .orange
                        )
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text(generalCap)
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundStyle(.secondary)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.white.opacity(0.6))
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .fill(generalColor.opacity(0.1))
            }
        }
        
    }
}

#Preview {
    NutrientGenereal(generalBody: "As gorduras (lipídios) são um grupo de nutrientes que fornecem energia, participam da produção de hormônios e ajudam na absorção de vitaminas lipossolúveis (A, D, E e K).", generalCap: "Fornecem 9 calorias por grama, sendo o nutriente mais calórico", generalColor: .yellow)
}
