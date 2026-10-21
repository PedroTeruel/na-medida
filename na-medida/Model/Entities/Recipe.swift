//
//  Recipe.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 29/09/26.
//

import Foundation
import SwiftData

@Model
final class Recipe{
    var name: String
    var creationDate: Date
    var tag: RecipeTag?
    
    @Relationship(deleteRule: .cascade, inverse: \RecipeIngredient.recipe)
    var ingredients: [RecipeIngredient] = []
    
    init(name: String, creationDate: Date = .now, tag: RecipeTag? = nil) {
        self.name = name
        self.creationDate = creationDate
        self.tag = tag
    }
}
enum RecipeTag: String, Codable, CaseIterable{
    case breakfast = "Café da manhã"
    case lunch = "Almoço"
    case dinner = "Jantar"
    case morningSnack = "Lanche da manhã"
    case afternoonSnack = "Lanche da tarde"
    case nightSnack = "Lanche da noite"
    case dessert = "Sobremesa"
}

enum RecipeSortOrder {
    case newest
    case oldest
    case fromA
    case fromZ
}

extension Recipe {
    
    var totalRecipeCalories: Double {
        ingredients.reduce(0) { $0 + $1.totalIngredientCalories }
    }
    
    var totalRecipeProteins: Double {
        ingredients.reduce(0) { $0 + $1.totalIngredientProteins }
    }
    
    var totalRecipeCarbs: Double {
        ingredients.reduce(0) { $0 + $1.totalIngredientCarbs }
    }
    
    var totalRecipeFats: Double {
        ingredients.reduce(0) { $0 + $1.totalIngredientFats }
    }
    
    var totalRecipeSodium: Double {
        ingredients.reduce(0) { $0 + $1.totalIngredientsSodium}
    }
    
    static func filterAndSort(
        _ recipes: [Recipe],
        by tag: RecipeTag?,
        sortOrder: RecipeSortOrder
    ) -> [Recipe] {
        let filtered = tag == nil ? recipes : recipes.filter { $0.tag == tag }
        
        switch sortOrder {
        case .fromA:
            return filtered.sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
        case .fromZ:
            return filtered.sorted { $0.name.localizedStandardCompare($1.name) == .orderedDescending }
        case .newest:
            return filtered.sorted { $0.creationDate > $1.creationDate }
        case .oldest:
            return filtered.sorted { $0.creationDate < $1.creationDate }
        }
    }
    
    static func search(_ recipes: [Recipe], query: String) -> [Recipe] {
        guard !query.isEmpty else { return [] }
        let lowerQuery = query.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        
        return recipes.filter { recipe in
            guard !recipe.isDeleted else { return false }
            return recipe.name
                .folding(options: .diacriticInsensitive, locale: .current)
                .lowercased()
                .contains(lowerQuery)
        }
    }
}
