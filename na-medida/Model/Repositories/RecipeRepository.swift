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
            let serving = dto.defaultServing
            
            let recipeIngredient = RecipeIngredient(
                userQuantity: draft.quantities[dto] ?? serving.quantity,
                unity: draft.units[dto] ?? serving.unit,
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
            let serving = dto.defaultServing
            
            let recipeIngredient = RecipeIngredient(
                userQuantity: serving.quantity,
                unity: serving.unit,
                ingredient: newIngredient,
                recipe: recipe
            )
            
            recipe.ingredients.append(recipeIngredient)
        }
        
        try? mc.save()
    }
    
    //funcs da editRecipe
    func saveChanges() throws {
        try mc.save()
    }


    func cancelChanges() {
        mc.rollback()
    }


    func removeIngredient(_ recipeIngredient: RecipeIngredient, from recipe: Recipe) {
        if let index = recipe.ingredients.firstIndex(where: { $0.persistentModelID == recipeIngredient.persistentModelID }) {
            recipe.ingredients.remove(at: index)
            mc.delete(recipeIngredient)
            try? mc.save()
        }
    }

}

