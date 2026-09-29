//
//  ModelContextTesteView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 29/09/26.
//

#warning("VIEW DE TEST PARA O SWIFTDATA")
import SwiftData
import SwiftUI

struct ModelContextTesteView: View {
    
    @Environment(\.modelContext) private var mc
    @Query private var recipes: [Recipe]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Criar nova receita"){
            let firstRecipe = Recipe(
                name: "Panqueca",
                tag: .dessert
            )
            
            mc.insert(firstRecipe)
            
        }
        
        List(recipes){ recipe in
            Text(recipe.name)
        }
    }
}

#Preview {
    ModelContextTesteView()
}
