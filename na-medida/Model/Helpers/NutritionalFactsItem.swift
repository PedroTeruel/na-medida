//
//  NutritionalFactsItem.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 01/10/26.
//

import Foundation

//modelo da tabela nutricional
struct NutritionalFactsItem: Identifiable {
    let id = UUID()
    let name: String          // Ex: "Carboidratos (g)"
    let value100g: String     // Ex: "13"
    let valuePortion: String  // Ex: "17"
    let dailyValue: String    // Ex: "%VD" (calculado com base na Anvisa)
    var isIndent: Bool = false // Sub-itens com recuo visual na UI
    var isBold: Bool = false   // Destaque em negrito na UI
}

// extension para mapeamento dados da api (dto)
extension ProductOpenFoodFactsDTO {
    
    var nutritionalItems: [NutritionalFactsItem] {
        guard let nutriments = self.nutriments else { return [] }
        
        let energyServing = nutriments.energyKcalServing
        let carbServing = nutriments.carbohydratesServing
        let protServing = nutriments.proteinsServing
        let fatServing = nutriments.fatServing
        let satFatServing = nutriments.saturatedFatServing
        let transFatServing = nutriments.transFatServing
        let fiberServing = nutriments.fiberServing
        let sodiumServing = nutriments.sodiumServing
        
        return [
            // Valor Energético: Exceção sem decimais (Ref: 2000 kcal)
            NutritionalFactsItem(
                name: "Valor energético (kcal)",
                value100g: AnvisaNutritionFormatter.formatEnergy(nutriments.energyKcal100g),
                valuePortion: AnvisaNutritionFormatter.formatEnergy(energyServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: energyServing, dailyReference: 2000),
                isBold: true
            ),
            // Carboidratos (Ref: 300g)
            NutritionalFactsItem(
                name: "Carboidratos (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.carbohydrates100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(carbServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: carbServing, dailyReference: 300),
                isBold: true
            ),
            // Açúcares Totais (sem %VD oficial)
            NutritionalFactsItem(
                name: "Açúcares totais (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.sugars100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.sugarsServing),
                dailyValue: "",
                isIndent: true
            ),
            // Açúcares Adicionados (Ref: 50g)
            NutritionalFactsItem(
                name: "Açúcares adicionados (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.addedSugars100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(nutriments.addedSugarsServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: nutriments.addedSugarsServing, dailyReference: 50),
                isIndent: true
            ),
            // Proteínas (Ref: 50g)
            NutritionalFactsItem(
                name: "Proteínas (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.proteins100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(protServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: protServing, dailyReference: 50),
                isBold: true
            ),
            // Gorduras Totais (Ref: 55g)
            NutritionalFactsItem(
                name: "Gorduras totais (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.fat100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(fatServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: fatServing, dailyReference: 55),
                isBold: true
            ),
            // Gorduras Saturadas (Ref: 20g)
            NutritionalFactsItem(
                name: "Gorduras saturadas (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.saturatedFat100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(satFatServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: satFatServing, dailyReference: 20),
                isIndent: true
            ),
            // Gorduras Trans (Ref: 2g)
            NutritionalFactsItem(
                name: "Gorduras trans (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.transFat100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(transFatServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: transFatServing, dailyReference: 2),
                isIndent: true
            ),
            // Fibras Alimentares (Ref: 25g)
            NutritionalFactsItem(
                name: "Fibras alimentares (g)",
                value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.fiber100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(fiberServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: fiberServing, dailyReference: 25),
                isBold: true
            ),
            // Sódio (Ref: 2000mg)
            NutritionalFactsItem(
                name: "Sódio (mg)",
                value100g: AnvisaNutritionFormatter.formatNutrient(nutriments.sodium100g),
                valuePortion: AnvisaNutritionFormatter.formatNutrient(sodiumServing),
                dailyValue: AnvisaNutritionFormatter.formatDailyValue(value: sodiumServing, dailyReference: 2000),
                isBold: true
            )
        ]
    }
}

enum AnvisaNutritionFormatter {
    
    static func formatNutrient(_ value: Double?) -> String {
        guard let val = value else { return "-" }
        
        //Inteiros obrigatórios (sem decimais)
        if val >= 10 {
            return "\(Int(val.rounded()))"
        }
        
        //1 casa decimal (arredondamento padrão)
        if val >= 1.0 {
            let formatted = String(format: "%.1f", val)
            return formatted.replacingOccurrences(of: ".", with: ",")
        }
        
        //Permite mais casas decimais (comum para micronutrientes)
        if val > 0 {
            let decimals = val < 0.1 ? 2 : 1
            let formatted = String(format: "%.\(decimals)f", val)
            return formatted.replacingOccurrences(of: ".", with: ",")
        }
        
        return "0"
    }
    
    static func formatEnergy(_ value: Double?) -> String {
        guard let val = value else { return "-" }
        return "\(Int(val.rounded()))"
    }
    
    static func formatDailyValue(value: Double?, dailyReference: Double) -> String {
        guard let val = value, dailyReference > 0 else { return "" }
        let vd = Int(((val / dailyReference) * 100.0).rounded())
        return "\(vd)"
    }
}
