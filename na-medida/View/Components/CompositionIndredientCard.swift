//
//  CompositionIndredientCard.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 02/10/26.
//
import SwiftUI

struct CompositionIngredientCard: View {
    // String contendo a lista de ingredientes (vinda do DTO)
    let ingredientsText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
                
                Text("Composição")
                    .font(.system(.title, weight: .bold))
                    .foregroundColor(Color("buttonColor"))
            
            // MARK: - Texto dos Ingredientes
            Text(ingredientsText.isEmpty ? "Informação de composição não disponível." : ingredientsText)
                .font(.system(.body))
                .foregroundColor(.primary)
                .lineSpacing(4)
                .multilineTextAlignment(.leading)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Preview (Xcode Canvas)
#Preview {
    let mockIngredients = "Farinha de trigo enriquecida com ferro e ácido fólico, açúcar, óleo vegetal, cacau, gordura vegetal, minerais cálcio e zinco (carbonato de cálcio e sulfato de zinco), chocolate, leite em pó integral, amido, sal, farinha de aveia, farinha de centeio, fermentos químicos (bicarbonato de amônio, fosfato monocálcico e bicarbonato de sódio), emulsificante (lecitina de soja) e aromatizantes."
    
    ScrollView {
        CompositionIngredientCard(ingredientsText: mockIngredients)
            .padding()
    }
}
