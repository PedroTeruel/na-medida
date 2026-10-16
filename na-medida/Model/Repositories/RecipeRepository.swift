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
        let codeToSearch: String? = {
            if let code = dto.code, !code.isEmpty { return code }
            if let tag = dto.countries_tags?.first, tag.hasPrefix("taco-") { return tag }
            return nil
        }()
        
        if let codeToSearch {
            let codeDescriptor = FetchDescriptor<Ingredient>(
                predicate: #Predicate { $0.barcode == codeToSearch }
            )
            if let existingByCode = try? mc.fetch(codeDescriptor).first {
                return existingByCode
            }
        }
        
        let nameToSearch = dto.productName ?? "Sem Nome"
        let brandToSearch = dto.brands
        
        let nameDescriptor = FetchDescriptor<Ingredient>(
            predicate: #Predicate { $0.name == nameToSearch && $0.brand == brandToSearch }
        )
        
        if let existingIngredient = try? mc.fetch(nameDescriptor).first {
            return existingIngredient
        }
        
        let created = Ingredient(from: dto)
        mc.insert(created)
        return created
    }
    
    func saveRecipe(draft: RecipeDraft) -> Recipe {
        let trimmedTitle = draft.title.trimmingCharacters(in: .whitespacesAndNewlines)
        let safeTitle = trimmedTitle.isEmpty ? "Nova Receita" : trimmedTitle
        let newRecipe = Recipe(name: safeTitle, tag: draft.tag)
        
        mc.insert(newRecipe)
        
        for dto in draft.ingredients {
            let ingredient = getOrCreateIngredient(from: dto)
            let serving = dto.defaultServing
            
            let recipeIngredient = RecipeIngredient(
                userQuantity: draft.quantities[dto] ?? serving.quantity,
                unity: draft.units[dto] ?? serving.unit,
                ingredient: ingredient,
                recipe: newRecipe
            )
            
            newRecipe.ingredients.append(recipeIngredient)
        }
        
        try? mc.save()
        return newRecipe
    }
    
    func addIngredients(to recipe: Recipe, from draft: RecipeDraft) {
        for dto in draft.ingredients {
            let ingredient = getOrCreateIngredient(from: dto)
            let serving = dto.defaultServing
            let quantity = draft.quantities[dto] ?? serving.quantity
            let unit = draft.units[dto] ?? serving.unit
            
            if let existingRecipeIng = recipe.ingredients.first(where: {
                $0.ingredient?.persistentModelID == ingredient.persistentModelID
            }) {
                existingRecipeIng.userQuantity = quantity
                existingRecipeIng.unity = unit
            } else {
                let recipeIngredient = RecipeIngredient(
                    userQuantity: quantity,
                    unity: unit,
                    ingredient: ingredient,
                    recipe: recipe
                )
                recipe.ingredients.append(recipeIngredient)
            }
        }
        
        try? mc.save()
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
    
    //funções da EditRecipeView
    func saveChanges() throws {
        try mc.save()
    }
    
    func cancelChanges() {
        mc.rollback()
    }
    
    func removeIngredient(_ recipeIngredient: RecipeIngredient, from recipe: Recipe, saveImmediately: Bool = true) {
        if let index = recipe.ingredients.firstIndex(where: { $0.persistentModelID == recipeIngredient.persistentModelID }) {
            recipe.ingredients.remove(at: index)
            mc.delete(recipeIngredient)
            if saveImmediately {
                try? mc.save()
            }
        }
    }
}
