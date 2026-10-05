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
    var tag: RecipeTag
    
    @Relationship(deleteRule: .cascade, inverse: \RecipeIngredient.recipe)
    var ingredients: [RecipeIngredient] = []
    
    init(name: String, creationDate: Date = .now, tag: RecipeTag) {
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
}
