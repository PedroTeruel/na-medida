//
//  NutrientsSource.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 08/10/26.
//

import SwiftUI

struct NutrientsSource: View {
    var cardTitle: String = "As medidas podem variar"
    var cardBody: String = "As gorduras (lipídios) são um grupo de nutrientes que fornecem energia, participam da produção de hormônios e ajudam na absorção de vitaminas lipossolúveis (A, D, E e K)."
    var sourceName: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Principais Funções")
                .font(.title3)
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
            HStack(){
                VStack(){
                    Image("OliveIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                    Text(sourceName)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.quinary.opacity(0.6))
                )
                Spacer()
                VStack(){
                    Image("OliveIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                    Text(sourceName)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.quinary.opacity(0.6))
                )

            }
        }
        
    }
}

#Preview {
    NutrientsSource(sourceName: "Azeite de Oliva")
}
