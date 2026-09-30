//
//  CardRecipe.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 30/09/26.
//
import SwiftUI
import SwiftData

struct CardRecipe: View {
    let recipe: Recipe
    
    // Obtém as URLs de imagem válidas dos ingredientes desta receita
    private var ingredientPhotoURLs: [String] {
        recipe.ingredients.compactMap { $0.ingredient?.photoURL }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            
            // 1. Fotos dos Ingredientes com Tratameno de Fallback
            if ingredientPhotoURLs.isEmpty {
                // Caso a receita não tenha fotos de ingredientes disponíveis da API
                Image(systemName: "fork.knife")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.gray.opacity(0.5))
            } else {
                HStack(spacing: -18) {
                    // Exibe até 3 fotos dos ingredientes
                    ForEach(Array(ingredientPhotoURLs.prefix(3).enumerated()), id: \.offset) { index, urlString in
                        AsyncImage(url: URL(string: urlString)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            default:
                                Color.gray.opacity(0.3)
                            }
                        }
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    }
                    
                    // Indicador para fotos adicionais (+X)
                    if ingredientPhotoURLs.count > 3 {
                        let extraCount = ingredientPhotoURLs.count - 3
                        
                        ZStack {
                            if let fourthURL = ingredientPhotoURLs.dropFirst(3).first {
                                AsyncImage(url: URL(string: fourthURL)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                            }
                            
                            Circle()
                                .fill(Color.black.opacity(0.65))
                                .frame(width: 70, height: 70)
                            
                            Text("+\(extraCount)")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    }
                }
            }
            
            // 2. Nome da Receita
            Text(recipe.name)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.2))
                .multilineTextAlignment(.center)
            
            // 3. Tags com os Totais Computados em Tempo Real
            HStack(spacing: 8) {
                MacroTagView(icon: "🍗", text: "\(Int(recipe.totalRecipeProteins))g prot.")
                MacroTagView(icon: "🔥", text: "\(Int(recipe.totalRecipeCalories)) Kcal")
                MacroTagView(icon: "🍞", text: "\(Int(recipe.totalRecipeCarbs))g Carbo")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 21)
        .frame(maxWidth: 360)
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 8)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.black.opacity(0.08), lineWidth: 1)
        )
    }
}

// MARK: - Subview Auxiliar para as Tags de Nutrientes
struct MacroTagView: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Text(icon)
                .font(.system(size: 14))
            
            Text(text)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.2))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color.black.opacity(0.08), lineWidth: 1)
        )
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Recipe.self, configurations: config)
    
    let sampleRecipe = Recipe(name: "Panqueca Proteica")
    
    return CardRecipe(recipe: sampleRecipe)
        .modelContainer(container)
}
