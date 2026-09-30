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
            
            // 1. Fotos dos Ingredientes com Tratametno de Fallback
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
                .font(.system(size: 19, weight: .semibold))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
            
            // 3. Tags com os Totais Computados em Tempo Real
            HStack(spacing: 8) {
                MacroTagView(
                    icon: "dumbbell.fill",
                    text: "\(Int(recipe.totalRecipeProteins))g",
                    color: .blue
                )

                MacroTagView(
                    icon: "flame.fill",
                    text: "\(Int(recipe.totalRecipeCalories)) Kcal",
                    color: .orange
                )

                MacroTagView(
                    icon: "chart.bar.fill",
                    text: "\(Int(recipe.totalRecipeCarbs))g",
                    color: .green
                )
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

struct MacroTagView: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(color)

            Text(text)
                .font(.system(size: 14, weight: .regular))
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
    let container = try! ModelContainer(
        for: Recipe.self,
        configurations: config
    )

    // Ingredientes/produtos de exemplo
    let banana = Ingredient(
        barcode: "0001",
        name: "Banana",
        brand: "Exemplo",
        photoURL: "https://images.openfoodfacts.org/images/products/401/440/092/0063/front_en.400.jpg",
        caloriesPer100g: 89,
        proteinsPer100g: 1.1,
        carbsPer100g: 22.8,
        fatsPer100g: 0.3
    )

    let aveia = Ingredient(
        barcode: "0002",
        name: "Aveia",
        brand: "Exemplo",
        photoURL: "https://images.openfoodfacts.org/images/products/316/893/001/0007/front_en.400.jpg",
        caloriesPer100g: 389,
        proteinsPer100g: 16.9,
        carbsPer100g: 66.3,
        fatsPer100g: 6.9
    )

    let leite = Ingredient(
        barcode: "0003",
        name: "Leite",
        brand: "Exemplo",
        photoURL: "https://images.openfoodfacts.org/images/products/356/007/012/5074/front_en.400.jpg",
        caloriesPer100g: 61,
        proteinsPer100g: 3.2,
        carbsPer100g: 4.8,
        fatsPer100g: 3.3
    )

    let ovo = Ingredient(
        barcode: "0004",
        name: "Ovo",
        brand: "Exemplo",
        photoURL: "https://images.openfoodfacts.org/images/products/327/019/002/5503/front_en.400.jpg",
        caloriesPer100g: 143,
        proteinsPer100g: 12.6,
        carbsPer100g: 0.7,
        fatsPer100g: 9.5
    )

    let morango = Ingredient(
        barcode: "0005",
        name: "Morango",
        brand: "Exemplo",
        photoURL: "https://images.openfoodfacts.org/images/products/356/007/011/9508/front_en.400.jpg",
        caloriesPer100g: 32,
        proteinsPer100g: 0.7,
        carbsPer100g: 7.7,
        fatsPer100g: 0.3
    )

    let pastaAmendoim = Ingredient(
        barcode: "0006",
        name: "Pasta de Amendoim",
        brand: "Exemplo",
        photoURL: "https://images.openfoodfacts.org/images/products/001/111/000/0030/front_en.400.jpg",
        caloriesPer100g: 588,
        proteinsPer100g: 25.0,
        carbsPer100g: 20.0,
        fatsPer100g: 50.0
    )

    // Receita
    let sampleRecipe = Recipe(
        name: "Panqueca Proteica",
        tag: .breakfast
    )

    // Ingredientes utilizados na receita
    let ingredients = [
        RecipeIngredient(
            userQuantity: 100,
            unity: .g,
            ingredient: banana,
            recipe: sampleRecipe
        ),
        RecipeIngredient(
            userQuantity: 50,
            unity: .g,
            ingredient: aveia,
            recipe: sampleRecipe
        ),
        RecipeIngredient(
            userQuantity: 100,
            unity: .ml,
            ingredient: leite,
            recipe: sampleRecipe
        ),
        RecipeIngredient(
            userQuantity: 2,
            unity: .un,
            ingredient: ovo,
            recipe: sampleRecipe
        ),
        RecipeIngredient(
            userQuantity: 50,
            unity: .g,
            ingredient: morango,
            recipe: sampleRecipe
        ),
        RecipeIngredient(
            userQuantity: 20,
            unity: .g,
            ingredient: pastaAmendoim,
            recipe: sampleRecipe
        )
    ]

    sampleRecipe.ingredients = ingredients

    return ScrollView {
        CardRecipe(recipe: sampleRecipe)
            .padding()
    }
    .modelContainer(container)
}
