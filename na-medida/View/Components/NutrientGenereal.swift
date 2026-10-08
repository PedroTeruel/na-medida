//
//  NutrientGenereal.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 08/10/26.
//

import SwiftUI

struct NutrientGenereal: View {
    var cardTitle: String = "As medidas podem variar"
    var cardBody: String = "As gorduras (lipídios) são um grupo de nutrientes que fornecem energia, participam da produção de hormônios e ajudam na absorção de vitaminas lipossolúveis (A, D, E e K)."
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            VStack(alignment: .leading, spacing: 8){
                Text("O que são?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                Text(cardBody)
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
                        
                        Text("Fornecem 9 calorias por grama, sendo o nutriente mais calórico.")
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
                    .fill(.blue.opacity(0.1))
            }
            VStack(){
                Text("Principais Funções")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
            }
          
        }
        
    }
}

#Preview {
    NutrientGenereal(cardTitle: "As medidas podem variar", cardBody: "As gorduras (lipídios) são um grupo de nutrientes que fornecem energia, participam da produção de hormônios e ajudam na absorção de vitaminas lipossolúveis (A, D, E e K).")
}
