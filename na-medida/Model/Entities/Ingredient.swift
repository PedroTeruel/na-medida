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
    var calcium100g: Double?
    var iron100g: Double?
    var zinc100g: Double?
    
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
    var calciumServing: Double?
    var ironServing: Double?
    var zincServing: Double?

    var vitaminC100g: Double?
    var vitaminE100g: Double?
    var vitaminB1100g: Double?
    var vitaminB2100g: Double?
    var vitaminB3100g: Double?
    var vitaminB5100g: Double?
    var vitaminB6100g: Double?
    
    var vitaminCServing: Double?
    var vitaminEServing: Double?
    var vitaminB1Serving: Double?
    var vitaminB2Serving: Double?
    var vitaminB3Serving: Double?
    var vitaminB5Serving: Double?
    var vitaminB6Serving: Double?

    var vitaminA100g: Double?
    var vitaminD100g: Double?
    var vitaminK100g: Double?
    var vitaminB7100g: Double?
    var vitaminB9100g: Double?
    var vitaminB12100g: Double?
    
    var vitaminAServing: Double?
    var vitaminDServing: Double?
    var vitaminKServing: Double?
    var vitaminB7Serving: Double?
    var vitaminB9Serving: Double?
    var vitaminB12Serving: Double?
    
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
        calcium100g: Double? = nil,
        iron100g: Double? = nil,
        zinc100g: Double? = nil,
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
        calciumServing: Double? = nil,
        ironServing: Double? = nil,
        zincServing: Double? = nil,
        vitaminC100g: Double? = nil,
        vitaminE100g: Double? = nil,
        vitaminB1100g: Double? = nil,
        vitaminB2100g: Double? = nil,
        vitaminB3100g: Double? = nil,
        vitaminB5100g: Double? = nil,
        vitaminB6100g: Double? = nil,
        vitaminCServing: Double? = nil,
        vitaminEServing: Double? = nil,
        vitaminB1Serving: Double? = nil,
        vitaminB2Serving: Double? = nil,
        vitaminB3Serving: Double? = nil,
        vitaminB5Serving: Double? = nil,
        vitaminB6Serving: Double? = nil,
        vitaminA100g: Double? = nil,
        vitaminD100g: Double? = nil,
        vitaminK100g: Double? = nil,
        vitaminB7100g: Double? = nil,
        vitaminB9100g: Double? = nil,
        vitaminB12100g: Double? = nil,
        vitaminAServing: Double? = nil,
        vitaminDServing: Double? = nil,
        vitaminKServing: Double? = nil,
        vitaminB7Serving: Double? = nil,
        vitaminB9Serving: Double? = nil,
        vitaminB12Serving: Double? = nil,
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
        self.calcium100g = calcium100g
        self.iron100g = iron100g
        self.zinc100g = zinc100g
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
        self.calciumServing = calciumServing
        self.ironServing = ironServing
        self.zincServing = zincServing
        self.vitaminC100g = vitaminC100g
        self.vitaminE100g = vitaminE100g
        self.vitaminB1100g = vitaminB1100g
        self.vitaminB2100g = vitaminB2100g
        self.vitaminB3100g = vitaminB3100g
        self.vitaminB5100g = vitaminB5100g
        self.vitaminB6100g = vitaminB6100g
        self.vitaminCServing = vitaminCServing
        self.vitaminEServing = vitaminEServing
        self.vitaminB1Serving = vitaminB1Serving
        self.vitaminB2Serving = vitaminB2Serving
        self.vitaminB3Serving = vitaminB3Serving
        self.vitaminB5Serving = vitaminB5Serving
        self.vitaminB6Serving = vitaminB6Serving
        self.vitaminA100g = vitaminA100g
        self.vitaminD100g = vitaminD100g
        self.vitaminK100g = vitaminK100g
        self.vitaminB7100g = vitaminB7100g
        self.vitaminB9100g = vitaminB9100g
        self.vitaminB12100g = vitaminB12100g
        self.vitaminAServing = vitaminAServing
        self.vitaminDServing = vitaminDServing
        self.vitaminKServing = vitaminKServing
        self.vitaminB7Serving = vitaminB7Serving
        self.vitaminB9Serving = vitaminB9Serving
        self.vitaminB12Serving = vitaminB12Serving
        self.ingredientsText = ingredientsText
        self.allergensText = allergensText
    }
}

extension Ingredient {
    var nutritionalItems: [NutritionalFactsItem] {
        var items = [
            NutritionalFactsItem(
                name: "Valor energético (kcal)",
                value100g: AnvisaNutritionFormatter.format(caloriesPer100g, scale: .kcal),
                valuePortion: AnvisaNutritionFormatter.format(caloriesServing, scale: .kcal),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: caloriesServing, scale: .kcal, dailyReference: 2000),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Carboidratos (g)",
                value100g: AnvisaNutritionFormatter.format(carbsPer100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(carbsServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: carbsServing, scale: .g, dailyReference: 300),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Açúcares totais (g)",
                value100g: AnvisaNutritionFormatter.format(sugars100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(sugarsServing, scale: .g),
                dailyValue: "",
                isIndent: true),
            
            NutritionalFactsItem(
                name: "Açúcares adicionados (g)",
                value100g: AnvisaNutritionFormatter.format(addedSugars100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(addedSugarsServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: addedSugarsServing, scale: .g, dailyReference: 50),
                isIndent: true),
            
            NutritionalFactsItem(
                name: "Proteínas (g)",
                value100g: AnvisaNutritionFormatter.format(proteinsPer100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(proteinsServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: proteinsServing, scale: .g, dailyReference: 50),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Gorduras totais (g)",
                value100g: AnvisaNutritionFormatter.format(fatsPer100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(fatsServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: fatsServing, scale: .g, dailyReference: 55),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Gorduras saturadas (g)",
                value100g: AnvisaNutritionFormatter.format(saturatedFats100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(saturatedFatsServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: saturatedFatsServing, scale: .g, dailyReference: 20),
                isIndent: true),
            
            NutritionalFactsItem(
                name: "Gorduras trans (g)",
                value100g: AnvisaNutritionFormatter.format(transFats100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(transFatsServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: transFatsServing, scale: .g, dailyReference: 2),
                isIndent: true),
            
            NutritionalFactsItem(
                name: "Fibras alimentares (g)",
                value100g: AnvisaNutritionFormatter.format(fiber100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(fiberServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: fiberServing, scale: .g, dailyReference: 25),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Sódio (mg)",
                value100g: AnvisaNutritionFormatter.format(sodium100g, scale: .mg),
                valuePortion: AnvisaNutritionFormatter.format(sodiumServing, scale: .mg),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: sodiumServing, scale: .mg, dailyReference: 2000),
                isBold: true)
        ]
        
        let vitsMg = [
            ("Vitamina C (mg)", vitaminC100g, vitaminCServing),
            ("Vitamina E (mg)", vitaminE100g, vitaminEServing),
            ("Vitamina B1 (mg)", vitaminB1100g, vitaminB1Serving),
            ("Vitamina B2 (mg)", vitaminB2100g, vitaminB2Serving),
            ("Vitamina B3 (mg)", vitaminB3100g, vitaminB3Serving),
            ("Vitamina B5 (mg)", vitaminB5100g, vitaminB5Serving),
            ("Vitamina B6 (mg)", vitaminB6100g, vitaminB6Serving)
        ]
        
        for (nome, v100g, vPortion) in vitsMg {
            if v100g != nil || vPortion != nil {
                items.append(NutritionalFactsItem(name: nome, value100g: AnvisaNutritionFormatter.format(v100g, scale: .mg), valuePortion: AnvisaNutritionFormatter.format(vPortion, scale: .mg), dailyValue: "", isBold: false))
            }
        }
        
        let vitsMcg = [
            ("Vitamina A (µg)", vitaminA100g, vitaminAServing),
            ("Vitamina D (µg)", vitaminD100g, vitaminDServing),
            ("Vitamina K (µg)", vitaminK100g, vitaminKServing),
            ("Vitamina B7/H (µg)", vitaminB7100g, vitaminB7Serving),
            ("Vitamina B9 (µg)", vitaminB9100g, vitaminB9Serving),
            ("Vitamina B12 (µg)", vitaminB12100g, vitaminB12Serving)
        ]
        
        for (nome, v100g, vPortion) in vitsMcg {
            if v100g != nil || vPortion != nil {
                items.append(NutritionalFactsItem(name: nome, value100g: AnvisaNutritionFormatter.format(v100g, scale: .mcg), valuePortion: AnvisaNutritionFormatter.format(vPortion, scale: .mcg), dailyValue: "", isBold: false))
            }
        }

        if calcium100g != nil || calciumServing != nil {
            items.append(NutritionalFactsItem(
                name: "Cálcio (mg)",
                value100g: AnvisaNutritionFormatter.format(calcium100g, scale: .mg),
                valuePortion: AnvisaNutritionFormatter.format(calciumServing, scale: .mg),
                dailyValue: "",
                isBold: false))
        }
        
        if iron100g != nil || ironServing != nil {
            items.append(NutritionalFactsItem(
                name: "Ferro (mg)",
                value100g: AnvisaNutritionFormatter.format(iron100g, scale: .mg),
                valuePortion: AnvisaNutritionFormatter.format(ironServing, scale: .mg),
                dailyValue: "",
                isBold: false))
        }
        
        if zinc100g != nil || zincServing != nil {
            items.append(NutritionalFactsItem(
                name: "Zinco (mg)",
                value100g: AnvisaNutritionFormatter.format(zinc100g, scale: .mg),
                valuePortion: AnvisaNutritionFormatter.format(zincServing, scale: .mg),
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
            calcium100g: dto.nutriments?.calcium100g,
            iron100g: dto.nutriments?.iron100g,
            zinc100g: dto.nutriments?.zinc100g,
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
            calciumServing: dto.nutriments?.calciumServing,
            ironServing: dto.nutriments?.ironServing,
            zincServing: dto.nutriments?.zincServing,
            vitaminC100g: dto.nutriments?.vitaminC100g,
            vitaminE100g: dto.nutriments?.vitaminE100g,
            vitaminB1100g: dto.nutriments?.vitaminB1100g,
            vitaminB2100g: dto.nutriments?.vitaminB2100g,
            vitaminB3100g: dto.nutriments?.vitaminB3100g,
            vitaminB5100g: dto.nutriments?.vitaminB5100g,
            vitaminB6100g: dto.nutriments?.vitaminB6100g,
            vitaminCServing: dto.nutriments?.vitaminCServing,
            vitaminEServing: dto.nutriments?.vitaminEServing,
            vitaminB1Serving: dto.nutriments?.vitaminB1Serving,
            vitaminB2Serving: dto.nutriments?.vitaminB2Serving,
            vitaminB3Serving: dto.nutriments?.vitaminB3Serving,
            vitaminB5Serving: dto.nutriments?.vitaminB5Serving,
            vitaminB6Serving: dto.nutriments?.vitaminB6Serving,
            vitaminA100g: dto.nutriments?.vitaminA100g,
            vitaminD100g: dto.nutriments?.vitaminD100g,
            vitaminK100g: dto.nutriments?.vitaminK100g,
            vitaminB7100g: dto.nutriments?.vitaminB7100g,
            vitaminB9100g: dto.nutriments?.vitaminB9100g,
            vitaminB12100g: dto.nutriments?.vitaminB12100g,
            vitaminAServing: dto.nutriments?.vitaminAServing,
            vitaminDServing: dto.nutriments?.vitaminDServing,
            vitaminKServing: dto.nutriments?.vitaminKServing,
            vitaminB7Serving: dto.nutriments?.vitaminB7Serving,
            vitaminB9Serving: dto.nutriments?.vitaminB9Serving,
            vitaminB12Serving: dto.nutriments?.vitaminB12Serving,
            ingredientsText: dto.composicaoProduto,
            allergensText: dto.allergens
        )
    }
}
