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
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.button
        
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.systemBackground],
            for: .selected
        )
        
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.label],
            for: .normal
        )
    }
    
    @State private var apiService = OpenFoodFactsService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(apiService)
        }
        .modelContainer(for: [
            Recipe.self,
            RecipeIngredient.self,
            Ingredient.self,
            User.self
        ])
    }
}
