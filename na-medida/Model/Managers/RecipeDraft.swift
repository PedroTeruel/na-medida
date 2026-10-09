//
//  RecipeDraft.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 04/10/26.
//

import Foundation
import Observation

@Observable
final class RecipeDraft {
    var title: String = ""
    var tag: RecipeTag? = nil
    var ingredients: [ProductOpenFoodFactsDTO] = []
    
    var editingRecipe: Recipe? = nil
    
    func addIngredient(_ dto: ProductOpenFoodFactsDTO) {
        if !ingredients.contains(dto) {
            ingredients.insert(dto, at: 0)
        }
    }
    
    func removeIngredient(_ dto: ProductOpenFoodFactsDTO) {
        ingredients.removeAll { $0 == dto }
    }
    
    func clear() {
        title = ""
        tag = nil
        ingredients.removeAll()
        editingRecipe = nil
    }
}
