//
//  OpenFoodFactsDTO.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import Foundation

struct BarcodeResponseDTO: Decodable {
    let code: String?
    let product: ProductOpenFoodFactsDTO?
    let status: String?
}

struct SearchResponseDTO: Decodable {
    let count: Int?
    let products: [ProductOpenFoodFactsDTO]?
}

struct ProductOpenFoodFactsDTO: Decodable, Hashable {
    let productName: String?
    let brands: String?
    let nutriments: NutrimentsDTO?
    let composicaoProduto: String?
    let allergens: String?
    let fotoProdutoURL: String?
    let imageUrl: String?
    let imageSmallUrl: String?
    let servingSize: String?
    let countries_tags: [String]?
    
    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case brands
        case nutriments
        case composicaoProduto = "ingredients_text"
        case allergens
        case fotoProdutoURL = "image_front_url"
        case imageUrl = "image_url"
        case imageSmallUrl = "image_small_url"
        case servingSize = "serving_size"
        case countries_tags
    }
    
    var photoProduct: String? {
        let bestUrl = fotoProdutoURL ?? imageUrl ?? imageSmallUrl
        return bestUrl?.replacingOccurrences(of: "http://", with: "https://")
    }
}

struct NutrimentsDTO: Decodable, Hashable {
    let energyKcal100g: Double?
    let proteins100g: Double?
    let carbohydrates100g: Double?
    let sugars100g: Double?
    let addedSugars100g: Double?
    let fat100g: Double?
    let saturatedFat100g: Double?
    let transFat100g: Double?
    let fiber100g: Double?
    let sodium100g: Double?
    
    let vitaminA100g: Double?
    let vitaminC100g: Double?
    let calcium100g: Double?
    let iron100g: Double?
    
    let energyKcalServing: Double?
    let proteinsServing: Double?
    let carbohydratesServing: Double?
    let sugarsServing: Double?
    let addedSugarsServing: Double?
    let fatServing: Double?
    let saturatedFatServing: Double?
    let transFatServing: Double?
    let fiberServing: Double?
    let sodiumServing: Double?
    
    let vitaminAServing: Double?
    let vitaminCServing: Double?
    let calciumServing: Double?
    let ironServing: Double?
    
    enum CodingKeys: String, CodingKey {
        case energyKcal100g = "energy-kcal_100g"
        case proteins100g = "proteins_100g"
        case carbohydrates100g = "carbohydrates_100g"
        case sugars100g = "sugars_100g"
        case addedSugars100g = "added-sugars_100g"
        case fat100g = "fat_100g"
        case saturatedFat100g = "saturated-fat_100g"
        case transFat100g = "trans-fat_100g"
        case fiber100g = "fiber_100g"
        case sodium100g = "sodium_100g"
        
        case vitaminA100g = "vitamin-a_100g"
        case vitaminC100g = "vitamin-c_100g"
        case calcium100g = "calcium_100g"
        case iron100g = "iron_100g"
        
        case energyKcalServing = "energy-kcal_serving"
        case proteinsServing = "proteins_serving"
        case carbohydratesServing = "carbohydrates_serving"
        case sugarsServing = "sugars_serving"
        case addedSugarsServing = "added-sugars_serving"
        case fatServing = "fat_serving"
        case saturatedFatServing = "saturated-fat_serving"
        case transFatServing = "trans-fat_serving"
        case fiberServing = "fiber_serving"
        case sodiumServing = "sodium_serving"
        
        case vitaminAServing = "vitamin-a_serving"
        case vitaminCServing = "vitamin-c_serving"
        case calciumServing = "calcium_serving"
        case ironServing = "iron_serving"
    }
}

extension ProductOpenFoodFactsDTO {
    var nutritionalItems: [NutritionalFactsItem] {
        guard let nutriments = self.nutriments else { return [] }
        
        var items = [
            NutritionalFactsItem(
                name: "Valor energético (kcal)",
                value100g: AnvisaNutritionFormatter.formatEnergy(nutriments.energyKcal100g),
                valuePortion: AnvisaNutritionFormatter.formatEnergy(nutriments.energyKcalServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: nutriments.energyKcalServing, dailyReference: 2000), isBold: true),
            
            NutritionalFactsItem(name: "Carboidratos (g)", value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.carbohydrates100g), valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.carbohydratesServing), dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: nutriments.carbohydratesServing, dailyReference: 300), isBold: true),
            
            NutritionalFactsItem(name: "Açúcares totais (g)", value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.sugars100g), valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.sugarsServing), dailyValue: "", isIndent: true),
            
            NutritionalFactsItem(name: "Açúcares adicionados (g)", value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.addedSugars100g), valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.addedSugarsServing), dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: nutriments.addedSugarsServing, dailyReference: 50), isIndent: true),
            
            NutritionalFactsItem(name: "Proteínas (g)", value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.proteins100g), valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.proteinsServing), dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: nutriments.proteinsServing, dailyReference: 50), isBold: true),
            
            NutritionalFactsItem(name: "Gorduras totais (g)", value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.fat100g), valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.fatServing), dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: nutriments.fatServing, dailyReference: 55), isBold: true),
            
            NutritionalFactsItem(name: "Gorduras saturadas (g)", value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.saturatedFat100g), valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.saturatedFatServing), dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: nutriments.saturatedFatServing, dailyReference: 20), isIndent: true),
            
            NutritionalFactsItem(name: "Gorduras trans (g)", value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.transFat100g), valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.transFatServing), dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: nutriments.transFatServing, dailyReference: 2), isIndent: true),
            
            NutritionalFactsItem(name: "Fibras alimentares (g)", value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.fiber100g), valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.fiberServing), dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: nutriments.fiberServing, dailyReference: 25), isBold: true),
            
            NutritionalFactsItem(name: "Sódio (mg)", value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.sodium100g), valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.sodiumServing), dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: nutriments.sodiumServing, dailyReference: 2000), isBold: true)
        ]
        
        if nutriments.calcium100g != nil || nutriments.calciumServing != nil {
            items.append(NutritionalFactsItem(name: "Cálcio", value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.calcium100g), valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.calciumServing), dailyValue: "", isBold: false))
        }
        if nutriments.iron100g != nil || nutriments.ironServing != nil {
            items.append(NutritionalFactsItem(name: "Ferro", value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.iron100g), valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.ironServing), dailyValue: "", isBold: false))
        }
        if nutriments.vitaminA100g != nil || nutriments.vitaminAServing != nil {
            items.append(NutritionalFactsItem(name: "Vitamina A", value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.vitaminA100g), valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.vitaminAServing), dailyValue: "", isBold: false))
        }
        if nutriments.vitaminC100g != nil || nutriments.vitaminCServing != nil {
            items.append(NutritionalFactsItem(name: "Vitamina C", value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.vitaminC100g), valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.vitaminCServing), dailyValue: "", isBold: false))
        }
        
        return items
    }
}
