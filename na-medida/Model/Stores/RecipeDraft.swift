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
    var quantities: [ProductOpenFoodFactsDTO: Double] = [:]
    var units: [ProductOpenFoodFactsDTO: QntUnity] = [:]
        
    func addIngredient(_ dto: ProductOpenFoodFactsDTO) {
        if !ingredients.contains(dto) {
            ingredients.insert(dto, at: 0)
            let serving = dto.defaultServing
            quantities[dto] = serving.quantity
            units[dto] = serving.unit
        }
    }
    
    func removeIngredient(_ dto: ProductOpenFoodFactsDTO) {
        ingredients.removeAll { $0 == dto }
        quantities.removeValue(forKey: dto)
        units.removeValue(forKey: dto)
    }
    
    func clear() {
        title = ""
        tag = nil
        ingredients.removeAll()
        quantities.removeAll()
        units.removeAll()
    }
}
