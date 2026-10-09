//
//  RecipeIngredient.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 29/09/26.
//

import Foundation
import SwiftData

@Model
final class RecipeIngredient {
    
    var userQuantity: Double // qtd inserida pelo user
    var unity: QntUnity // unidade selecionada pelo user
    var recipe: Recipe? //vinculo com alguma Recipe
    var ingredient: Ingredient? // Vínculo com algum Ingredient
    
    init(userQuantity: Double, unity: QntUnity, ingredient: Ingredient? = nil, recipe: Recipe? = nil) {
        self.userQuantity = userQuantity
        self.unity = unity
        self.ingredient = ingredient
        self.recipe = recipe
    }
}

enum QntUnity: String, Codable {
    case un, g, kg, ml, l
    
    var formatted: String {
        switch self {
        case .un: return "Un"
        case .g: return "g"
        case .kg: return "kg"
        case .ml: return "mL"
        case .l:  return "L"
        default:  return self.rawValue
        }
    }
}

extension RecipeIngredient {
    
    private var weightMultiplier: Double {
        switch unity {
        case .g, .ml:
            return userQuantity / 100.0
        case .kg, .l:
            return (userQuantity * 1000.0) / 100.0
        case .un:
            return 0.0
        }
    }
    
    var totalIngredientCalories: Double {
        if unity == .un {
            //se for unidade, multiplica pelo valor da porção
            let val = ingredient?.caloriesServing ?? ingredient?.caloriesPer100g ?? 0.0
            return val * userQuantity
        } else {
            //se for g, kg, ml ou L, usa o peso proporcional
            return (ingredient?.caloriesPer100g ?? 0.0) * weightMultiplier
        }
    }
    
    var totalIngredientProteins: Double {
        if unity == .un {
            let val = ingredient?.proteinsServing ?? ingredient?.proteinsPer100g ?? 0.0
            return val * userQuantity
        } else {
            return (ingredient?.proteinsPer100g ?? 0.0) * weightMultiplier
        }
    }
    
    var totalIngredientCarbs: Double {
        if unity == .un {
            let val = ingredient?.carbsServing ?? ingredient?.carbsPer100g ?? 0.0
            return val * userQuantity
        } else {
            return (ingredient?.carbsPer100g ?? 0.0) * weightMultiplier
        }
    }
    
    var totalIngredientFats: Double {
        if unity == .un {
            let val = ingredient?.fatsServing ?? ingredient?.fatsPer100g ?? 0.0
            return val * userQuantity
        } else {
            return (ingredient?.fatsPer100g ?? 0.0) * weightMultiplier
        }
    }
    
    var totalIngredientsSodium: Double {
        if unity == .un {
            let val = ingredient?.sodiumServing ?? ingredient?.sodium100g ?? 0.0
            return val * userQuantity
        } else {
            return (ingredient?.sodium100g ?? 0.0) * weightMultiplier
        }
    }
}
