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

            HStack(){
                VStack(spacing: 12){
                    Image("OliveIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                    Text(sourceName)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 80, height: 120)
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
    NutrientsSource(sourceName: "Peixes Gordurosos")
}
