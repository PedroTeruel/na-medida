//
//  Recipe.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 29/09/26.
//

import Foundation
import SwiftData
import SwiftUI

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

extension RecipeTag {
    var color: Color {
        switch self {
        case .breakfast: return Color.tagCardOrange
        case .lunch: return Color.tagCardGreen
        case .dinner: return Color.tagCardPurple
        case .morningSnack: return Color.tagColorRed
        case .afternoonSnack: return Color.tagColorPink
        case .nightSnack: return Color.tagColorBlue
        case .dessert: return Color.tagCardYellow
        }
    }

    // Useful when you need readable text over the tag color
    var foregroundColor: Color {
        switch self {
        case .breakfast: return Color.tagTextOrange
        case .lunch: return Color.tagTextGreen
        case .dinner: return Color.tagTextPurple
        case .morningSnack: return Color.tagTextRed
        case .afternoonSnack: return Color.tagTextPink
        case .nightSnack: return Color.tagTextBlue
        case .dessert: return Color.tagTextYellow
        }
    }
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
