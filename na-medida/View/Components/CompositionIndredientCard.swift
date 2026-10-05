//
//  CompositionIndredientCard.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 02/10/26.
//

import SwiftUI

struct CompositionIngredientCard: View {
    let ingredientsText: String
    let allergensText: String?
    
    private var formattedAllergens: String? {
        guard let allergens = allergensText, !allergens.isEmpty else {
            return nil }
        return allergens
            .replacingOccurrences(of: "en", with: "")
            .replacingOccurrences(of: "pt", with: "")
            .replacingOccurrences(of: "fr", with: "")
            .capitalized
    }
        
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
                
                Text("Composição")
                    .font(.system(.title, weight: .bold))
                    .foregroundColor(Color("buttonColor"))
            
            Text(ingredientsText.isEmpty ? "Informação de composição não disponível para este produto" : ingredientsText)
                .font(.system(.body))
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
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
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
