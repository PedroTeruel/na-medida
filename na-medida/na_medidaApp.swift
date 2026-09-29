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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            Recipe.self,
            RecipeIngredient.self,
            Ingredient.self
        ])
    }
}
