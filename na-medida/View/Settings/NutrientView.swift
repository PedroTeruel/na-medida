//
//  NutrientView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 06/10/26.
//

import SwiftUI

struct NutrientView: View {
    @State var segmentedControl = 0
    var nutrientName: String
    var nutrientImg: String
    var nutrientDescription: String
    var body: some View {
        ScrollView{
            VStack(alignment: .center, spacing: 22){
                VStack(alignment: .center){
                    Image(nutrientImg)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120, alignment: .center)
                    Text(nutrientName)
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(nutrientDescription)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: 280)
                Picker("Informações", selection: $segmentedControl) {
                    Text("Visão Geral").tag(0)
                    Text("Fontes").tag(1)
                }
                .pickerStyle(.segmented)
                
                if segmentedControl == 0 {
                    NutrientGenereal(cardTitle: "As medidas podem variar", cardBody: "As gorduras (lipídios) são um grupo de nutrientes que fornecem energia, participam da produção de hormônios e ajudam na absorção de vitaminas lipossolúveis (A, D, E e K).")
                }
                else{
                    NutrientsSource(sourceName: "Azeite de Oliva")
                    MeasureWarningCard()
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack{
        NutrientView(nutrientName: "Calorias", nutrientImg: "CaloriesIcon", nutrientDescription: "Energia, hormônios e absorção de vitaminas")
    }
}
