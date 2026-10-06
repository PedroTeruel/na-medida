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

enum AnvisaNutritionFormatter {
    
    static func formatNutrient(_ value: Double?) -> String {
        guard let val = value else { return "-" }
        
        if val >= 10 {
            return "\(Int(val.rounded()))"
        }
        
        if val >= 1.0 {
            let formatted = String(format: "%.1f", val)
            return formatted.replacingOccurrences(of: ".", with: ",")
        }
        
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
