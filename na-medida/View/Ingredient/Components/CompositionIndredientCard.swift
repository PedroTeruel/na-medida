//
//  CompositionIndredientCard.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 02/10/26.
//

import SwiftUI

struct CompositionIngredientCard: View {
    
    @Environment(\.colorScheme) private var colorScheme
    let ingredientsText: String
    let allergensText: String?
    
    private static let allergenTranslations: [String: String] = [
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
    
    private var formattedAllergens: String? {
        guard let rawAllergens = allergensText, !rawAllergens.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
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
                if let translated = Self.allergenTranslations[lower] {
                    return translated
                }
                return cleaned.capitalized
            }
        
        guard !items.isEmpty else { return nil }
        return items.joined(separator: ", ")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Composição")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(ingredientsText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Informação de composição não disponível para este produto" : ingredientsText)
                .font(.body)
                .foregroundColor(.primary)
                .lineSpacing(4)
                .multilineTextAlignment(.leading)
            
            if let allergens = formattedAllergens {
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                        Text("Alergênicos")
                    }
                    .fontWeight(.regular)
                    
                    Text(allergens)
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                        .lineSpacing(4)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(colorScheme == .dark ? Color(.secondarySystemBackground) : .white)
                .shadow(
                    color: .black.opacity(0.12),
                    radius: 2,
                    x: 0,
                    y: 2
                )
        }
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.primary.opacity(0.15), lineWidth: 1)
        }
    }
}

#Preview {
    let mockIngredients = "Farinha de trigo enriquecida com ferro, açúcar, cacau, leite em pó integral, sal."
    let mockAllergens = "en:gluten, pt:leite, en:soybeans"
    
    ScrollView {
        CompositionIngredientCard(
            ingredientsText: mockIngredients,
            allergensText: mockAllergens
        )
        .padding()
    }
}
