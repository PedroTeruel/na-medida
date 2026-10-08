//
//  na_medidaApp.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 28/09/26.
//

import SwiftData
import SwiftUI

@main
struct na_medidaApp: App {
    
    @State private var apiService = OpenFoodFactsService()
    @State private var tacoService = TacoService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(apiService)
                .environment(tacoService)
        }
        .modelContainer(for: [
            Recipe.self,
            RecipeIngredient.self,
            Ingredient.self,
            User.self
        ])
    }
}
