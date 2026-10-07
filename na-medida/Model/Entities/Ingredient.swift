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
    var servingSize: String?
    
    var caloriesPer100g: Double
    var proteinsPer100g: Double
    var carbsPer100g: Double
    var fatsPer100g: Double
    var sugars100g: Double?
    var addedSugars100g: Double?
    var saturatedFats100g: Double?
    var transFats100g: Double?
    var fiber100g: Double?
    var sodium100g: Double?
    var vitaminA100g: Double?
    var vitaminC100g: Double?
    var calcium100g: Double?
    var iron100g: Double?
    
    var caloriesServing: Double?
    var proteinsServing: Double?
    var carbsServing: Double?
    var fatsServing: Double?
    var sugarsServing: Double?
    var addedSugarsServing: Double?
    var saturatedFatsServing: Double?
    var transFatsServing: Double?
    var fiberServing: Double?
    var sodiumServing: Double?
    var vitaminAServing: Double?
    var vitaminCServing: Double?
    var calciumServing: Double?
    var ironServing: Double?
    
    var ingredientsText: String?
    var allergensText: String?
    
    init(
        barcode: String?,
        id: UUID = UUID(),
        name: String,
        brand: String? = nil,
        photoURL: String? = nil,
        servingSize: String? = nil,
        caloriesPer100g: Double = 0.0,
        proteinsPer100g: Double = 0.0,
        carbsPer100g: Double = 0.0,
        fatsPer100g: Double = 0.0,
        sugars100g: Double? = nil,
        addedSugars100g: Double? = nil,
        saturatedFats100g: Double? = nil,
        transFats100g: Double? = nil,
        fiber100g: Double? = nil,
        sodium100g: Double? = nil,
        vitaminA100g: Double? = nil,
        vitaminC100g: Double? = nil,
        calcium100g: Double? = nil,
        iron100g: Double? = nil,
        caloriesServing: Double? = nil,
        proteinsServing: Double? = nil,
        carbsServing: Double? = nil,
        fatsServing: Double? = nil,
        sugarsServing: Double? = nil,
        addedSugarsServing: Double? = nil,
        saturatedFatsServing: Double? = nil,
        transFatsServing: Double? = nil,
        fiberServing: Double? = nil,
        sodiumServing: Double? = nil,
        vitaminAServing: Double? = nil,
        vitaminCServing: Double? = nil,
        calciumServing: Double? = nil,
        ironServing: Double? = nil,
        ingredientsText: String? = nil,
        allergensText: String? = nil
    ) {
        self.barcode = barcode
        self.id = id
        self.name = name
        self.brand = brand
        self.photoURL = photoURL
        self.servingSize = servingSize
        self.caloriesPer100g = caloriesPer100g
        self.proteinsPer100g = proteinsPer100g
        self.carbsPer100g = carbsPer100g
        self.fatsPer100g = fatsPer100g
        self.sugars100g = sugars100g
        self.addedSugars100g = addedSugars100g
        self.saturatedFats100g = saturatedFats100g
        self.transFats100g = transFats100g
        self.fiber100g = fiber100g
        self.sodium100g = sodium100g
        self.vitaminA100g = vitaminA100g
        self.vitaminC100g = vitaminC100g
        self.calcium100g = calcium100g
        self.iron100g = iron100g
        self.caloriesServing = caloriesServing
        self.proteinsServing = proteinsServing
        self.carbsServing = carbsServing
        self.fatsServing = fatsServing
        self.sugarsServing = sugarsServing
        self.addedSugarsServing = addedSugarsServing
        self.saturatedFatsServing = saturatedFatsServing
        self.transFatsServing = transFatsServing
        self.fiberServing = fiberServing
        self.sodiumServing = sodiumServing
        self.vitaminAServing = vitaminAServing
        self.vitaminCServing = vitaminCServing
        self.calciumServing = calciumServing
        self.ironServing = ironServing
        self.ingredientsText = ingredientsText
        self.allergensText = allergensText
    }
}

extension Ingredient {
    var nutritionalItems: [NutritionalFactsItem] {
        var items = [
            NutritionalFactsItem(
                name: "Valor energético (kcal)",
                value100g: AnvisaNutritionFormatter.formatEnergy(caloriesPer100g),
                valuePortion: AnvisaNutritionFormatter.formatEnergy(caloriesServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: caloriesServing, dailyReference: 2000),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Carboidratos (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(carbsPer100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(carbsServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: carbsServing, dailyReference: 300),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Açúcares totais (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(sugars100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(sugarsServing),
                dailyValue: "",
                isIndent: true),
            
            NutritionalFactsItem(
                name: "Açúcares adicionados (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(addedSugars100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(addedSugarsServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: addedSugarsServing, dailyReference: 50),
                isIndent: true),
            
            NutritionalFactsItem(
                name: "Proteínas (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(proteinsPer100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(proteinsServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: proteinsServing, dailyReference: 50),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Gorduras totais (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(fatsPer100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(fatsServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: fatsServing, dailyReference: 55),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Gorduras saturadas (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(saturatedFats100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(saturatedFatsServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: saturatedFatsServing, dailyReference: 20),
                isIndent: true),
            
            NutritionalFactsItem(
                name: "Gorduras trans (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(transFats100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(transFatsServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: transFatsServing, dailyReference: 2),
                isIndent: true),
            
            NutritionalFactsItem(
                name: "Fibras alimentares (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(fiber100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(fiberServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: fiberServing, dailyReference: 25),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Sódio (mg)",
                value100g: AnvisaNutritionFormatter.formatNutrient(sodium100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(sodiumServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: sodiumServing, dailyReference: 2000),
                isBold: true)
        ]
        
        if calcium100g != nil || calciumServing != nil {
            items.append(NutritionalFactsItem(
                name: "Cálcio",
                value100g: AnvisaNutritionFormatter.formatNutrient(calcium100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(calciumServing),
                dailyValue: "",
                isBold: false))
        }
        if iron100g != nil || ironServing != nil {
            items.append(NutritionalFactsItem(
                name: "Ferro",
                value100g: AnvisaNutritionFormatter.formatNutrient(iron100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(ironServing),
                dailyValue: "",
                isBold: false))
        }
        if vitaminA100g != nil || vitaminAServing != nil {
            items.append(NutritionalFactsItem(
                name: "Vitamina A",
                value100g: AnvisaNutritionFormatter.formatNutrient(vitaminA100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(vitaminAServing),
                dailyValue: "",
                isBold: false))
        }
        if vitaminC100g != nil || vitaminCServing != nil {
            items.append(NutritionalFactsItem(
                name: "Vitamina C",
                value100g: AnvisaNutritionFormatter.formatNutrient(vitaminC100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(vitaminCServing),
                dailyValue: "",
                isBold: false))
        }
        
        return items
    }
    
    convenience init(from dto: ProductOpenFoodFactsDTO) {
        self.init(
            barcode: dto.countries_tags?.first,
            name: dto.productName ?? "Sem Nome",
            brand: dto.brands,
            photoURL: dto.fotoProdutoURL,
            servingSize: dto.servingSize,
            caloriesPer100g: dto.nutriments?.energyKcal100g ?? 0.0,
            proteinsPer100g: dto.nutriments?.proteins100g ?? 0.0,
            carbsPer100g: dto.nutriments?.carbohydrates100g ?? 0.0,
            fatsPer100g: dto.nutriments?.fat100g ?? 0.0,
            sugars100g: dto.nutriments?.sugars100g,
            addedSugars100g: dto.nutriments?.addedSugars100g,
            saturatedFats100g: dto.nutriments?.saturatedFat100g,
            transFats100g: dto.nutriments?.transFat100g,
            fiber100g: dto.nutriments?.fiber100g,
            sodium100g: dto.nutriments?.sodium100g,
            vitaminA100g: dto.nutriments?.vitaminA100g,
            vitaminC100g: dto.nutriments?.vitaminC100g,
            calcium100g: dto.nutriments?.calcium100g,
            iron100g: dto.nutriments?.iron100g,
            caloriesServing: dto.nutriments?.energyKcalServing,
            proteinsServing: dto.nutriments?.proteinsServing,
            carbsServing: dto.nutriments?.carbohydratesServing,
            fatsServing: dto.nutriments?.fatServing,
            sugarsServing: dto.nutriments?.sugarsServing,
            addedSugarsServing: dto.nutriments?.addedSugarsServing,
            saturatedFatsServing: dto.nutriments?.saturatedFatServing,
            transFatsServing: dto.nutriments?.transFatServing,
            fiberServing: dto.nutriments?.fiberServing,
            sodiumServing: dto.nutriments?.sodiumServing,
            vitaminAServing: dto.nutriments?.vitaminAServing,
            vitaminCServing: dto.nutriments?.vitaminCServing,
            calciumServing: dto.nutriments?.calciumServing,
            ironServing: dto.nutriments?.ironServing,
            ingredientsText: dto.composicaoProduto,
            allergensText: dto.allergens
        )
    }
}
