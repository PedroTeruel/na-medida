//
//  RecipeIngredient.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 29/09/26.
//

import Foundation
import SwiftData

@Model
final class RecipeIngredient{
    var quantity: Double
    var unity: QntUnity
    
    var recipe: Recipe?
    
    init(quantity: Double, unity: QntUnity, recipe: Recipe? = nil) {
        self.quantity = quantity
        self.unity = unity
        self.recipe = recipe
    }
}

enum QntUnity: String, Codable{
    case un
    case g
    case kg
    case ml
    case l
}
