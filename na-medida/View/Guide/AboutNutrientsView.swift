//
//  AboutNutrientsView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 06/10/26.
//

import SwiftUI

struct AboutNutrientsView: View {
    @State var segmentedControl = 0
//    var text: String
//    var isFocused: Bool = false
    var body: some View {
       
        ScrollView{
            VStack(alignment: .leading, spacing: 22){
                Text("Descubra para que servem os principais Nutrientes")
                    .font(.body)
                    .foregroundStyle(.secondary)
                
//                SearchBarComponent(
//                    searchText: $text,
//                    isSearchFocused: $isFocused,
//                    onSearchSubmit: { _ in }
//                )
                VStack(){
                    NutrientsCard(nutrientImg: "FatIcon")
                    NutrientsCard(nutrientName: "Carboídratos", nutrientDescription: "Principal fonte de energia do corpo", nutrientImg: "CarbIcon")
                    NutrientsCard(nutrientName: "Calorias", nutrientDescription: "Energia que o corpo utiliza", nutrientImg: "CaloriesIcon")
                    NutrientsCard(nutrientName: "Proteínas", nutrientDescription: "Construção muscular e reparo dos tecidos", nutrientImg: "ProtIcon")
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
    NavigationStack{
        AboutNutrientsView()
    }
}
