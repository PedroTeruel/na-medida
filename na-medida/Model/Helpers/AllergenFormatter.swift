//
//  AllergenFormatter.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 21/10/26.
//

import Foundation

enum AllergenFormatter {
    private static let translations: [String: String] = [
        "gluten": "Glúten",
        "milk": "Leite",
        "soybeans": "Soja",
        "eggs": "Ovos",
        "peanuts": "Amendoim",
        "nuts": "Castanhas/Nozes",
        "fish": "Peixe",
        "crustaceans": "Crustáceos",
        "mustard": "Mostarda",
        "sesame-seeds": "Gergelim",
        "sulphur-dioxide-and-sulphites": "Sulfitos",
        "celery": "Aipo",
        "lupin": "Tremoço",
        "molluscs": "Moluscos",
        "oats": "Aveia",
        "wheat": "Trigo"
    ]
    
    static func format(_ rawAllergens: String?) -> String? {
        guard let rawAllergens,
              !rawAllergens.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil
        }
        
        let items = rawAllergens
            .components(separatedBy: ",")
            .compactMap { part -> String? in
                var cleaned = part.trimmingCharacters(in: .whitespacesAndNewlines)
                if let colonRange = cleaned.range(of: ":") {
                    cleaned = String(cleaned[colonRange.upperBound...])
                }
                cleaned = cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !cleaned.isEmpty else { return nil }
                
                let lower = cleaned.lowercased()
                if let translated = translations[lower] {
                    return translated
                }
                return cleaned.capitalized
            }
        
        guard !items.isEmpty else { return nil }
        return items.joined(separator: ", ")
    }
}
