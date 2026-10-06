//
//  IngredientEntity.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 29/09/26.
//

import Foundation
import SwiftData

@Model
final class Ingredient {
    var barcode: String?
    var id: UUID
    var name: String
    var brand: String?
    var photoURL: String?
    var caloriesPer100g: Double
    var proteinsPer100g: Double
    var carbsPer100g: Double
    var fatsPer100g: Double
    var ingredientsText: String?
    var allergensText: String?
    
    init(
        barcode: String?,
        id: UUID = UUID(),
        name: String,
        brand: String? = nil,
        photoURL: String? = nil,
        caloriesPer100g: Double = 0.0,
        proteinsPer100g: Double = 0.0,
        carbsPer100g: Double = 0.0,
        fatsPer100g: Double = 0.0,
        ingredientsText: String? = nil,
        allergensText: String? = nil
        
        
    ) {
        self.barcode = barcode
        self.id = id
        self.name = name
        self.brand = brand
        self.photoURL = photoURL
        self.caloriesPer100g = caloriesPer100g
        self.proteinsPer100g = proteinsPer100g
        self.carbsPer100g = carbsPer100g
        self.fatsPer100g = fatsPer100g
        self.ingredientsText = ingredientsText
        self.allergensText = allergensText
    }
}

extension Ingredient {
    var nutritionalItems: [NutritionalFactsItem] {
        return [
            NutritionalFactsItem(
                name: "Valor energético (kcal)",
                value100g: AnvisaNutritionFormatter.formatEnergy(caloriesPer100g),
                valuePortion: "-", dailyValue: "", isBold: true),
            
            NutritionalFactsItem(
                name: "Carboidratos (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(carbsPer100g),
                valuePortion: "-", dailyValue: "", isBold: true),
            
            NutritionalFactsItem(
                name: "Proteínas (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(proteinsPer100g),
                valuePortion: "-", dailyValue: "", isBold: true),
            
            NutritionalFactsItem(
                name: "Gorduras (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(fatsPer100g),
                valuePortion: "-", dailyValue: "", isBold: true)
        ]
    }
    
    convenience init(from dto: ProductOpenFoodFactsDTO) {
        self.init(
            barcode: nil,
            name: dto.productName ?? "Sem Nome",
            brand: dto.brands,
            photoURL: dto.fotoProdutoURL,
            caloriesPer100g: dto.nutriments?.energyKcal100g ?? 0.0,
            proteinsPer100g: dto.nutriments?.proteins100g ?? 0.0,
            carbsPer100g: dto.nutriments?.carbohydrates100g ?? 0.0,
            fatsPer100g: dto.nutriments?.fat100g ?? 0.0,
            ingredientsText: dto.composicaoProduto,
            allergensText: dto.allergens
        )
    }
}

