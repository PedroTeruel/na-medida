//
//  AppRoute.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 21/10/26.
//

import Foundation

enum AppRoute: Hashable {
    case recipesinfo(Recipe)
    case newrecipe
    case scanner(Recipe?)
    case savedIngredient(Ingredient)
    case aboutNutrients
    case aboutMeasures
    case aboutUs
    case termsOfUse
    case editrecipe(Recipe)
    case nutrientInfo(Nutrient)
    case privacyPolicy
}
