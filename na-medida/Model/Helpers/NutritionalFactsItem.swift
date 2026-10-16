//
//  NutritionalFactsItem.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 01/10/26.
//

import Foundation

struct NutritionalFactsItem: Identifiable {
    let id = UUID()
    let name: String
    let value100g: String
    let valuePortion: String
    let dailyValue: String
    var isIndent: Bool = false
    var isBold: Bool = false
}

import Foundation

enum NutrientScale {
    case kcal
    case g
    case mg
    case mcg
    case percent
    
    var multiplier: Double {
        switch self {
        case .kcal, .g, .percent: return 1.0
        case .mg: return 1_000.0
        case .mcg: return 1_000_000.0
        }
    }
}

enum AnvisaNutritionFormatter {
    
    static func format(_ apiValue: Double?, scale: NutrientScale) -> String {
        guard let val = apiValue else { return "-" }
        
        let scaledValue = val * scale.multiplier
        
        if scaledValue <= 0 {
            return "0"
        }
        
        let locale = Locale(identifier: "pt_BR")
        
        switch scale {
        case .kcal, .percent:
            return scaledValue.formatted(.number.locale(locale).precision(.fractionLength(0)))
            
        case .g, .mg, .mcg:
            if scaledValue >= 10 {
                return scaledValue.formatted(.number.locale(locale).precision(.fractionLength(0)))
            } else if scaledValue >= 1 {
                return scaledValue.formatted(.number.locale(locale).precision(.fractionLength(0...1)))
            } else {
                return scaledValue.formatted(.number.locale(locale).precision(.fractionLength(0...2)))
            }
        }
    }
    
    static func formatDailyValue(apiValue: Double?, scale: NutrientScale, dailyReference: Double) -> String {
        guard let val = apiValue, dailyReference > 0 else { return "" }
        
        let scaledValue = val * scale.multiplier
        let vd = (scaledValue / dailyReference) * 100.0
        
        return format(vd, scale: .percent)
    }
}
