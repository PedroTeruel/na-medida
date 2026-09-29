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
    
    init(name: String, creationDate: Date = .now) {
        self.name = name
        self.creationDate = creationDate
        self.tag = tag
    }
}
enum RecipeTag: String{
    case breakfast
    case lauch
    case dinner
    case snack
    case desert
}
