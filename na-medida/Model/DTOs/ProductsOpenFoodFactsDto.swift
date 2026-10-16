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
    let code: String?
    let productName: String?
    let brands: String?
    let nutriments: NutrimentsDTO?
    let composicaoProduto: String?
    let allergens: String?
    let fotoProdutoURL: String?
    let imageUrl: String?
    let imageSmallUrl: String?
    let servingSize: String?
    let quantity: String?
    let countries_tags: [String]?
    
    enum CodingKeys: String, CodingKey {
        case code
        case productName = "product_name"
        case brands
        case nutriments
        case composicaoProduto = "ingredients_text"
        case allergens
        case fotoProdutoURL = "image_front_url"
        case imageUrl = "image_url"
        case imageSmallUrl = "image_small_url"
        case servingSize = "serving_size"
        case quantity
        case countries_tags
    }
    
    init(
        code: String? = nil,
        productName: String? = nil,
        brands: String? = nil,
        nutriments: NutrimentsDTO? = nil,
        composicaoProduto: String? = nil,
        allergens: String? = nil,
        fotoProdutoURL: String? = nil,
        imageUrl: String? = nil,
        imageSmallUrl: String? = nil,
        servingSize: String? = nil,
        quantity: String? = nil,
        countries_tags: [String]? = nil
    ) {
        self.code = code
        self.productName = productName
        self.brands = brands
        self.nutriments = nutriments
        self.composicaoProduto = composicaoProduto
        self.allergens = allergens
        self.fotoProdutoURL = fotoProdutoURL
        self.imageUrl = imageUrl
        self.imageSmallUrl = imageSmallUrl
        self.servingSize = servingSize
        self.quantity = quantity
        self.countries_tags = countries_tags
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
    
    let vitaminC100g: Double?
    let vitaminE100g: Double?
    let vitaminB1100g: Double?
    let vitaminB2100g: Double?
    let vitaminB3100g: Double?
    let vitaminB5100g: Double?
    let vitaminB6100g: Double?
    let calcium100g: Double?
    let iron100g: Double?
    let zinc100g: Double?
    
    let vitaminCServing: Double?
    let vitaminEServing: Double?
    let vitaminB1Serving: Double?
    let vitaminB2Serving: Double?
    let vitaminB3Serving: Double?
    let vitaminB5Serving: Double?
    let vitaminB6Serving: Double?
    let calciumServing: Double?
    let ironServing: Double?
    let zincServing: Double?
    
    let vitaminA100g: Double?
    let vitaminD100g: Double?
    let vitaminK100g: Double?
    let vitaminB7100g: Double?
    let vitaminB9100g: Double?
    let vitaminB12100g: Double?
    
    let vitaminAServing: Double?
    let vitaminDServing: Double?
    let vitaminKServing: Double?
    let vitaminB7Serving: Double?
    let vitaminB9Serving: Double?
    let vitaminB12Serving: Double?
    
    init(
        energyKcal100g: Double? = nil,
        proteins100g: Double? = nil,
        carbohydrates100g: Double? = nil,
        sugars100g: Double? = nil,
        addedSugars100g: Double? = nil,
        fat100g: Double? = nil,
        saturatedFat100g: Double? = nil,
        transFat100g: Double? = nil,
        fiber100g: Double? = nil,
        sodium100g: Double? = nil,
        energyKcalServing: Double? = nil,
        proteinsServing: Double? = nil,
        carbohydratesServing: Double? = nil,
        sugarsServing: Double? = nil,
        addedSugarsServing: Double? = nil,
        fatServing: Double? = nil,
        saturatedFatServing: Double? = nil,
        transFatServing: Double? = nil,
        fiberServing: Double? = nil,
        sodiumServing: Double? = nil,
        vitaminC100g: Double? = nil,
        vitaminE100g: Double? = nil,
        vitaminB1100g: Double? = nil,
        vitaminB2100g: Double? = nil,
        vitaminB3100g: Double? = nil,
        vitaminB5100g: Double? = nil,
        vitaminB6100g: Double? = nil,
        calcium100g: Double? = nil,
        iron100g: Double? = nil,
        zinc100g: Double? = nil,
        vitaminCServing: Double? = nil,
        vitaminEServing: Double? = nil,
        vitaminB1Serving: Double? = nil,
        vitaminB2Serving: Double? = nil,
        vitaminB3Serving: Double? = nil,
        vitaminB5Serving: Double? = nil,
        vitaminB6Serving: Double? = nil,
        calciumServing: Double? = nil,
        ironServing: Double? = nil,
        zincServing: Double? = nil,
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
        vitaminB12Serving: Double? = nil
    ) {
        self.energyKcal100g = energyKcal100g
        self.proteins100g = proteins100g
        self.carbohydrates100g = carbohydrates100g
        self.sugars100g = sugars100g
        self.addedSugars100g = addedSugars100g
        self.fat100g = fat100g
        self.saturatedFat100g = saturatedFat100g
        self.transFat100g = transFat100g
        self.fiber100g = fiber100g
        self.sodium100g = sodium100g
        self.energyKcalServing = energyKcalServing
        self.proteinsServing = proteinsServing
        self.carbohydratesServing = carbohydratesServing
        self.sugarsServing = sugarsServing
        self.addedSugarsServing = addedSugarsServing
        self.fatServing = fatServing
        self.saturatedFatServing = saturatedFatServing
        self.transFatServing = transFatServing
        self.fiberServing = fiberServing
        self.sodiumServing = sodiumServing
        self.vitaminC100g = vitaminC100g
        self.vitaminE100g = vitaminE100g
        self.vitaminB1100g = vitaminB1100g
        self.vitaminB2100g = vitaminB2100g
        self.vitaminB3100g = vitaminB3100g
        self.vitaminB5100g = vitaminB5100g
        self.vitaminB6100g = vitaminB6100g
        self.calcium100g = calcium100g
        self.iron100g = iron100g
        self.zinc100g = zinc100g
        self.vitaminCServing = vitaminCServing
        self.vitaminEServing = vitaminEServing
        self.vitaminB1Serving = vitaminB1Serving
        self.vitaminB2Serving = vitaminB2Serving
        self.vitaminB3Serving = vitaminB3Serving
        self.vitaminB5Serving = vitaminB5Serving
        self.vitaminB6Serving = vitaminB6Serving
        self.calciumServing = calciumServing
        self.ironServing = ironServing
        self.zincServing = zincServing
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
    }
    
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
        
        case vitaminC100g = "vitamin-c_100g"
        case vitaminE100g = "vitamin-e_100g"
        case vitaminB1100g = "vitamin-b1_100g"
        case vitaminB2100g = "vitamin-b2_100g"
        case vitaminB3100g = "vitamin-pp_100g"
        case vitaminB5100g = "pantothenic-acid_100g"
        case vitaminB6100g = "vitamin-b6_100g"
        case calcium100g = "calcium_100g"
        case iron100g = "iron_100g"
        case zinc100g = "zinc_100g"
        
        case vitaminCServing = "vitamin-c_serving"
        case vitaminEServing = "vitamin-e_serving"
        case vitaminB1Serving = "vitamin-b1_serving"
        case vitaminB2Serving = "vitamin-b2_serving"
        case vitaminB3Serving = "vitamin-pp_serving"
        case vitaminB5Serving = "pantothenic-acid_serving"
        case vitaminB6Serving = "vitamin-b6_serving"
        case calciumServing = "calcium_serving"
        case ironServing = "iron_serving"
        case zincServing = "zinc_serving"
        
        case vitaminA100g = "vitamin-a_100g"
        case vitaminD100g = "vitamin-d_100g"
        case vitaminK100g = "vitamin-k_100g"
        case vitaminB7100g = "biotin_100g"
        case vitaminB9100g = "vitamin-b9_100g"
        case vitaminB12100g = "vitamin-b12_100g"
        
        case vitaminAServing = "vitamin-a_serving"
        case vitaminDServing = "vitamin-d_serving"
        case vitaminKServing = "vitamin-k_serving"
        case vitaminB7Serving = "biotin_serving"
        case vitaminB9Serving = "vitamin-b9_serving"
        case vitaminB12Serving = "vitamin-b12_serving"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        func decodeDouble(_ key: CodingKeys) -> Double? {
            if let val = try? container.decodeIfPresent(Double.self, forKey: key) {
                return val
            }
            if let intVal = try? container.decodeIfPresent(Int.self, forKey: key) {
                return Double(intVal)
            }
            if let strVal = try? container.decodeIfPresent(String.self, forKey: key) {
                let cleaned = strVal.replacingOccurrences(of: ",", with: ".").trimmingCharacters(in: .whitespaces)
                return Double(cleaned)
            }
            return nil
        }
        
        self.energyKcal100g = decodeDouble(.energyKcal100g)
        self.proteins100g = decodeDouble(.proteins100g)
        self.carbohydrates100g = decodeDouble(.carbohydrates100g)
        self.sugars100g = decodeDouble(.sugars100g)
        self.addedSugars100g = decodeDouble(.addedSugars100g)
        self.fat100g = decodeDouble(.fat100g)
        self.saturatedFat100g = decodeDouble(.saturatedFat100g)
        self.transFat100g = decodeDouble(.transFat100g)
        self.fiber100g = decodeDouble(.fiber100g)
        self.sodium100g = decodeDouble(.sodium100g)
        
        self.energyKcalServing = decodeDouble(.energyKcalServing)
        self.proteinsServing = decodeDouble(.proteinsServing)
        self.carbohydratesServing = decodeDouble(.carbohydratesServing)
        self.sugarsServing = decodeDouble(.sugarsServing)
        self.addedSugarsServing = decodeDouble(.addedSugarsServing)
        self.fatServing = decodeDouble(.fatServing)
        self.saturatedFatServing = decodeDouble(.saturatedFatServing)
        self.transFatServing = decodeDouble(.transFatServing)
        self.fiberServing = decodeDouble(.fiberServing)
        self.sodiumServing = decodeDouble(.sodiumServing)
        
        self.vitaminC100g = decodeDouble(.vitaminC100g)
        self.vitaminE100g = decodeDouble(.vitaminE100g)
        self.vitaminB1100g = decodeDouble(.vitaminB1100g)
        self.vitaminB2100g = decodeDouble(.vitaminB2100g)
        self.vitaminB3100g = decodeDouble(.vitaminB3100g)
        self.vitaminB5100g = decodeDouble(.vitaminB5100g)
        self.vitaminB6100g = decodeDouble(.vitaminB6100g)
        self.calcium100g = decodeDouble(.calcium100g)
        self.iron100g = decodeDouble(.iron100g)
        self.zinc100g = decodeDouble(.zinc100g)
        
        self.vitaminCServing = decodeDouble(.vitaminCServing)
        self.vitaminEServing = decodeDouble(.vitaminEServing)
        self.vitaminB1Serving = decodeDouble(.vitaminB1Serving)
        self.vitaminB2Serving = decodeDouble(.vitaminB2Serving)
        self.vitaminB3Serving = decodeDouble(.vitaminB3Serving)
        self.vitaminB5Serving = decodeDouble(.vitaminB5Serving)
        self.vitaminB6Serving = decodeDouble(.vitaminB6Serving)
        self.calciumServing = decodeDouble(.calciumServing)
        self.ironServing = decodeDouble(.ironServing)
        self.zincServing = decodeDouble(.zincServing)
        
        self.vitaminA100g = decodeDouble(.vitaminA100g)
        self.vitaminD100g = decodeDouble(.vitaminD100g)
        self.vitaminK100g = decodeDouble(.vitaminK100g)
        self.vitaminB7100g = decodeDouble(.vitaminB7100g)
        self.vitaminB9100g = decodeDouble(.vitaminB9100g)
        self.vitaminB12100g = decodeDouble(.vitaminB12100g)
        
        self.vitaminAServing = decodeDouble(.vitaminAServing)
        self.vitaminDServing = decodeDouble(.vitaminDServing)
        self.vitaminKServing = decodeDouble(.vitaminKServing)
        self.vitaminB7Serving = decodeDouble(.vitaminB7Serving)
        self.vitaminB9Serving = decodeDouble(.vitaminB9Serving)
        self.vitaminB12Serving = decodeDouble(.vitaminB12Serving)
    }
}

extension ProductOpenFoodFactsDTO {
    
    private static let measureRegex = try? NSRegularExpression(
        pattern: #"(\d+(?:[.,]\d+)?)\s*(ml|l|kg|g)\b"#,
        options: .caseInsensitive
    )
    
    private static let unitRegex = try? NSRegularExpression(
        pattern: #"(\d+(?:[.,]\d+)?)\s*(un|und|unid|unidade|unidades)\b"#,
        options: .caseInsensitive
    )
    
    var defaultServing: (quantity: Double, unit: QntUnity) {
        let candidates = [quantity, productName, servingSize].compactMap { $0 }
        
        for rawText in candidates where !rawText.isEmpty {
            if let parsed = parseMeasure(from: rawText) {
                return parsed
            }
        }
        
        return (100.0, .g)
    }
    
    private func parseMeasure(from text: String) -> (quantity: Double, unit: QntUnity)? {
        if let regex = Self.measureRegex,
           let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
           let valueRange = Range(match.range(at: 1), in: text),
           let unitRange = Range(match.range(at: 2), in: text) {
            
            let valueString = text[valueRange].replacingOccurrences(of: ",", with: ".")
            let unitString = text[unitRange].lowercased()
            
            if let value = Double(valueString) {
                let unit: QntUnity
                switch unitString {
                case "ml": unit = .ml
                case "l":  unit = .l
                case "kg": unit = .kg
                default:   unit = .g
                }
                return (value, unit)
            }
        }
        
        if let regex = Self.unitRegex,
           let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
           let valueRange = Range(match.range(at: 1), in: text) {
            
            let valueString = text[valueRange].replacingOccurrences(of: ",", with: ".")
            if let value = Double(valueString) {
                return (value, .un)
            }
        }
        
        return nil
    }
    
    var nutritionalItems: [NutritionalFactsItem] {
        guard let nutriments = self.nutriments else { return [] }
        
        var items = [
            NutritionalFactsItem(
                name: "Valor energético (kcal)",
                value100g: AnvisaNutritionFormatter.format(nutriments.energyKcal100g, scale: .kcal),
                valuePortion: AnvisaNutritionFormatter.format(nutriments.energyKcalServing, scale: .kcal),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: nutriments.energyKcalServing, scale: .kcal, dailyReference: 2000),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Carboidratos (g)",
                value100g: AnvisaNutritionFormatter.format(nutriments.carbohydrates100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(nutriments.carbohydratesServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: nutriments.carbohydratesServing, scale: .g, dailyReference: 300),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Açúcares totais (g)",
                value100g: AnvisaNutritionFormatter.format(nutriments.sugars100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(nutriments.sugarsServing, scale: .g),
                dailyValue: "",
                isIndent: true),
            
            NutritionalFactsItem(
                name: "Açúcares adicionados (g)",
                value100g: AnvisaNutritionFormatter.format(nutriments.addedSugars100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(nutriments.addedSugarsServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: nutriments.addedSugarsServing, scale: .g, dailyReference: 50),
                isIndent: true),
            
            NutritionalFactsItem(
                name: "Proteínas (g)",
                value100g: AnvisaNutritionFormatter.format(nutriments.proteins100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(nutriments.proteinsServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: nutriments.proteinsServing, scale: .g, dailyReference: 50),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Gorduras totais (g)",
                value100g: AnvisaNutritionFormatter.format(nutriments.fat100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(nutriments.fatServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: nutriments.fatServing, scale: .g, dailyReference: 55),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Gorduras saturadas (g)",
                value100g: AnvisaNutritionFormatter.format(nutriments.saturatedFat100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(nutriments.saturatedFatServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: nutriments.saturatedFatServing, scale: .g, dailyReference: 20),
                isIndent: true),
            
            NutritionalFactsItem(
                name: "Gorduras trans (g)",
                value100g: AnvisaNutritionFormatter.format(nutriments.transFat100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(nutriments.transFatServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: nutriments.transFatServing, scale: .g, dailyReference: 2),
                isIndent: true),
            
            NutritionalFactsItem(
                name: "Fibras alimentares (g)",
                value100g: AnvisaNutritionFormatter.format(nutriments.fiber100g, scale: .g),
                valuePortion: AnvisaNutritionFormatter.format(nutriments.fiberServing, scale: .g),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: nutriments.fiberServing, scale: .g, dailyReference: 25),
                isBold: true),
            
            NutritionalFactsItem(
                name: "Sódio (mg)",
                value100g: AnvisaNutritionFormatter.format(nutriments.sodium100g, scale: .mg),
                valuePortion: AnvisaNutritionFormatter.format(nutriments.sodiumServing, scale: .mg),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(apiValue: nutriments.sodiumServing, scale: .mg, dailyReference: 2000),
                isBold: true)
        ]
        
        let vitsMg = [
            ("Vitamina C (mg)", nutriments.vitaminC100g, nutriments.vitaminCServing),
            ("Vitamina E (mg)", nutriments.vitaminE100g, nutriments.vitaminEServing),
            ("Vitamina B1 (mg)", nutriments.vitaminB1100g, nutriments.vitaminB1Serving),
            ("Vitamina B2 (mg)", nutriments.vitaminB2100g, nutriments.vitaminB2Serving),
            ("Vitamina B3 (mg)", nutriments.vitaminB3100g, nutriments.vitaminB3Serving),
            ("Vitamina B5 (mg)", nutriments.vitaminB5100g, nutriments.vitaminB5Serving),
            ("Vitamina B6 (mg)", nutriments.vitaminB6100g, nutriments.vitaminB6Serving)
        ]
        
        for (nome, v100g, vPortion) in vitsMg {
            if v100g != nil || vPortion != nil {
                items.append(NutritionalFactsItem(name: nome, value100g: AnvisaNutritionFormatter.format(v100g, scale: .mg), valuePortion: AnvisaNutritionFormatter.format(vPortion, scale: .mg), dailyValue: "", isBold: false))
            }
        }
        
        let vitsMcg = [
            ("Vitamina A (µg)", nutriments.vitaminA100g, nutriments.vitaminAServing),
            ("Vitamina D (µg)", nutriments.vitaminD100g, nutriments.vitaminDServing),
            ("Vitamina K (µg)", nutriments.vitaminK100g, nutriments.vitaminKServing),
            ("Vitamina B7/H (µg)", nutriments.vitaminB7100g, nutriments.vitaminB7Serving),
            ("Vitamina B9 (µg)", nutriments.vitaminB9100g, nutriments.vitaminB9Serving),
            ("Vitamina B12 (µg)", nutriments.vitaminB12100g, nutriments.vitaminB12Serving)
        ]
        
        for (nome, v100g, vPortion) in vitsMcg {
            if v100g != nil || vPortion != nil {
                items.append(NutritionalFactsItem(name: nome, value100g: AnvisaNutritionFormatter.format(v100g, scale: .mcg), valuePortion: AnvisaNutritionFormatter.format(vPortion, scale: .mcg), dailyValue: "", isBold: false))
            }
        }
        
        if nutriments.calcium100g != nil || nutriments.calciumServing != nil {
            items.append(NutritionalFactsItem(name: "Cálcio (mg)", value100g: AnvisaNutritionFormatter.format(nutriments.calcium100g, scale: .mg), valuePortion: AnvisaNutritionFormatter.format(nutriments.calciumServing, scale: .mg), dailyValue: "", isBold: false))
        }
        
        if nutriments.iron100g != nil || nutriments.ironServing != nil {
            items.append(NutritionalFactsItem(name: "Ferro (mg)", value100g: AnvisaNutritionFormatter.format(nutriments.iron100g, scale: .mg), valuePortion: AnvisaNutritionFormatter.format(nutriments.ironServing, scale: .mg), dailyValue: "", isBold: false))
        }
        
        if nutriments.zinc100g != nil || nutriments.zincServing != nil {
            items.append(NutritionalFactsItem(name: "Zinco (mg)", value100g: AnvisaNutritionFormatter.format(nutriments.zinc100g, scale: .mg), valuePortion: AnvisaNutritionFormatter.format(nutriments.zincServing, scale: .mg), dailyValue: "", isBold: false))
        }
        
        return items
    }
}
