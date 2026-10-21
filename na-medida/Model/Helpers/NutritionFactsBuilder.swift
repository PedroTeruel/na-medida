//
//  NutritionFactsBuilder.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 21/10/26.
//

import Foundation

enum NutritionFactsBuilder {
    static func build(
        energyKcal100g: Double?, energyKcalServing: Double?,
        carbohydrates100g: Double?, carbohydratesServing: Double?,
        sugars100g: Double?, sugarsServing: Double?,
        addedSugars100g: Double?, addedSugarsServing: Double?,
        proteins100g: Double?, proteinsServing: Double?,
        fats100g: Double?, fatsServing: Double?,
        saturatedFats100g: Double?, saturatedFatsServing: Double?,
        transFats100g: Double?, transFatsServing: Double?,
        fiber100g: Double?, fiberServing: Double?,
        sodium100g: Double?, sodiumServing: Double?,
        vitaminC100g: Double?, vitaminCServing: Double?,
        vitaminE100g: Double?, vitaminEServing: Double?,
        vitaminB1100g: Double?, vitaminB1Serving: Double?,
        vitaminB2100g: Double?, vitaminB2Serving: Double?,
        vitaminB3100g: Double?, vitaminB3Serving: Double?,
        vitaminB5100g: Double?, vitaminB5Serving: Double?,
        vitaminB6100g: Double?, vitaminB6Serving: Double?,
        vitaminA100g: Double?, vitaminAServing: Double?,
        vitaminD100g: Double?, vitaminDServing: Double?,
        vitaminK100g: Double?, vitaminKServing: Double?,
        vitaminB7100g: Double?, vitaminB7Serving: Double?,
        vitaminB9100g: Double?, vitaminB9Serving: Double?,
        vitaminB12100g: Double?, vitaminB12Serving: Double?,
        calcium100g: Double?, calciumServing: Double?,
        iron100g: Double?, ironServing: Double?,
        zinc100g: Double?, zincServing: Double?
    ) -> [NutritionalFactsItem] {
        
        var items = [
            NutritionalFactsItem(
                name: "Valor energético (kcal)",
                value100g: AnvisaNutritionFormatter.format(energyKcal100g, scale: .kcal),
                valuePortion: AnvisaNutritionFormatter.format(energyKcalServing, scale: .kcal),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: energyKcalServing, scale: .kcal, dailyReference: 2000),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Carboidratos (g)",
                value100g: AnvisaNutritionFormatter.format(carbohydrates100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(carbohydratesServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: carbohydratesServing, scale: .g, dailyReference: 300),
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
                value100g: AnvisaNutritionFormatter.format(proteins100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(proteinsServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: proteinsServing, scale: .g, dailyReference: 50),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Gorduras totais (g)",
                value100g: AnvisaNutritionFormatter.format(fats100g, scale: .g),
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
            items.append(NutritionalFactsItem(name: "Cálcio (mg)", value100g: AnvisaNutritionFormatter.format(calcium100g, scale: .mg), valuePortion: AnvisaNutritionFormatter.format(calciumServing, scale: .mg), dailyValue: "", isBold: false))
        }
        
        if iron100g != nil || ironServing != nil {
            items.append(NutritionalFactsItem(name: "Ferro (mg)", value100g: AnvisaNutritionFormatter.format(iron100g, scale: .mg), valuePortion: AnvisaNutritionFormatter.format(ironServing, scale: .mg), dailyValue: "", isBold: false))
        }
        
        if zinc100g != nil || zincServing != nil {
            items.append(NutritionalFactsItem(name: "Zinco (mg)", value100g: AnvisaNutritionFormatter.format(zinc100g, scale: .mg), valuePortion: AnvisaNutritionFormatter.format(zincServing, scale: .mg), dailyValue: "", isBold: false))
        }
        
        return items
    }
}
