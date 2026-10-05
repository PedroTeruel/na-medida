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
    var tag: RecipeTag = .breakfast
    var ingredients: [ProductOpenFoodFactsDTO] = []
    
    var editingRecipe: Recipe? = nil
    
    func addIngredient(_ dto: ProductOpenFoodFactsDTO) {
        if !ingredients.contains(dto) {
            ingredients.append(dto)
        }
    }
    
    func removeIngredient(_ dto: ProductOpenFoodFactsDTO) {
        ingredients.removeAll { $0 == dto }
    }
    
    func clear() {
        title = ""
        tag = .breakfast
        ingredients.removeAll()
        editingRecipe = nil
    }
}
