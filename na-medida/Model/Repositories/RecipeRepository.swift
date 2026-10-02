//
//  RecipeRepository.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 02/10/26.
//

import SwiftData
import Foundation

@Observable
final class RecipeRepository {
    private let mc: ModelContext
    
    init(mc: ModelContext) {
        self.mc = mc
    }
    
    func saveRecipe(title: String, tag: RecipeTag, dtoIngredients: [ProductOpenFoodFactsDTO]) -> Recipe {
            let safeTitle = title.isEmpty ? "Nova Receita" : title
            let newRecipe = Recipe(name: safeTitle, tag: tag)
            
            for dto in dtoIngredients {
                let newIngredient = Ingredient(
                    barcode: nil,
                    name: dto.productName ?? "Sem Nome",
                    brand: dto.brands,
                    photoURL: dto.fotoProdutoURL,
                    caloriesPer100g: dto.nutriments?.energyKcal100g ?? 0.0,
                    proteinsPer100g: dto.nutriments?.proteins100g ?? 0.0,
                    carbsPer100g: dto.nutriments?.carbohydrates100g ?? 0.0,
                    fatsPer100g: dto.nutriments?.fat100g ?? 0.0
                )
                
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
    }
