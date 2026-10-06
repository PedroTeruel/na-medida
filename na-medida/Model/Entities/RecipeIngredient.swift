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

//enum QntUnity: String, Codable {
//    case un // Unidade
//    case g  // Grama
//    case kg // Quilograma
//    case ml // Mililitro
//    case l  // Litro
//}

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

//extension com calculo dos macronutriente da receita
extension RecipeIngredient {
    
//normalizando a quantidade que o usuario digitar para g ou mL
    private var baseQuantity: Double {
        switch unity {
        case .g, .ml, .un:
            return userQuantity
        case .kg, .l:
            return userQuantity * 1000.0
        }
    }
    
//regra de tres para calcular os nutrientes com a userQuantity normalizada
    private var multiplier: Double {
        return baseQuantity / 100.0
    }
    //propiedades computadas -> os macros da receita nao seroa armazenados no banco de dados, só serao calculados na hora
    var totalIngredientCalories: Double {
            (ingredient?.caloriesPer100g ?? 0.0) * multiplier
        }
        
        var totalIngredientProteins: Double {
            (ingredient?.proteinsPer100g ?? 0.0) * multiplier
        }
        
        var totalIngredientCarbs: Double {
            (ingredient?.carbsPer100g ?? 0.0) * multiplier
        }
        
        var totalIngredientFats: Double {
            (ingredient?.fatsPer100g ?? 0.0) * multiplier
    }
}
