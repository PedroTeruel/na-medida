//
//  RecipeRepository.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 02/10/26.
//

import SwiftData
import Foundation

final class RecipeRepository {
    private let mc: ModelContext
    
    init(mc: ModelContext) {
        self.mc = mc
    }
    
    private func getOrCreateIngredient(from dto: ProductOpenFoodFactsDTO) -> Ingredient {
        let nameToSearch = dto.productName ?? "Sem Nome"
        
        let descriptor = FetchDescriptor<Ingredient>(
            predicate: #Predicate { $0.name == nameToSearch }
        )
        
        if let existingIngredient = try? mc.fetch(descriptor).first {
            return existingIngredient
        }
        
        return Ingredient(from: dto)
    }
    
    func saveRecipe(draft: RecipeDraft) -> Recipe {
        let safeTitle = draft.title.isEmpty ? "Nova Receita" : draft.title
        let newRecipe = Recipe(name: safeTitle, tag: draft.tag)
        
        for dto in draft.ingredients {
            let newIngredient = getOrCreateIngredient(from: dto)
            
            let recipeIngredient = RecipeIngredient(
                userQuantity: 100.0,
                unity: .g,
                ingredient: newIngredient,
                recipe: newRecipe
            )
            
            newRecipe.ingredients.append(recipeIngredient)
        }
        
        mc.insert(newRecipe)
        try? mc.save()
        
        return newRecipe
    }
    
    func addIngredients(to recipe: Recipe, dtos: [ProductOpenFoodFactsDTO]) {
        for dto in dtos {
            let newIngredient = getOrCreateIngredient(from: dto)
            
            let recipeIngredient = RecipeIngredient(
                userQuantity: 100.0,
                unity: .g,
                ingredient: newIngredient,
                recipe: recipe
            )
            
            recipe.ingredients.append(recipeIngredient)
        }
        
        try? mc.save()
    }
}
