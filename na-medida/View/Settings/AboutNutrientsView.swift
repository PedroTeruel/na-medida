//
//  AboutNutrientsView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 06/10/26.
//

import SwiftUI

struct AboutNutrientsView: View {
    @State var segmentedControl = 0
    var body: some View {
       
        ScrollView{
            VStack(alignment: .leading, spacing: 22){
                Text("Descubra para que servem os principais Nutrientes")
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                // Componente da barra de pesquisa
                VStack(){
                    NutrientsCard(nutrientImg: "FatIcon")
                    NutrientsCard(nutrientName: "Carboídratos", nutrientDescription: "Principal fonte de energia do corpo", nutrientImg: "CarboIcon")
                    NutrientsCard(nutrientName: "Calorias", nutrientDescription: "Energia que o corpo utiliza", nutrientImg: "CaloriesIcon")
                    NutrientsCard(nutrientName: "Proteínas", nutrientDescription: "Construção muscular e reparo dos tecidos", nutrientImg: "ProteinIcon")
                    NutrientsCard(nutrientName: "Sódio", nutrientDescription: "Equilibrio de fluidos e função nervosa", nutrientImg: "SodiumIcon")
                }
                
                
            }
            .padding(.horizontal)
            .navigationTitle("Definição dos Nutrientes")
            .navigationBarTitleDisplayMode(.large)
        }
        
    }
}

#Preview {
    AboutNutrientsView()
}
