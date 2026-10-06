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
    
    private var ingredientPhotoURLs: [String] {
        recipe.ingredients.compactMap { $0.ingredient?.photoURL }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            
            if ingredientPhotoURLs.isEmpty {
                Image(systemName: "fork.knife")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.primary.opacity(0.5))
            } else {
                HStack(spacing: -18) {
                    
                    let hasExtra = ingredientPhotoURLs.count > 4
                    let visibleCount = hasExtra ? 3 : ingredientPhotoURLs.count
                    
                    ForEach(0..<visibleCount, id: \.self) { index in
                        RecipeIngredientImageView(urlString: ingredientPhotoURLs[index])
                            .transition(.scale.combined(with: .opacity))
                    }
                    
                    if hasExtra {
                        let extraCount = ingredientPhotoURLs.count - 3
                        
                        ZStack {
                            RecipeIngredientImageView(urlString: ingredientPhotoURLs[3])
                            
                            Circle()
                                .fill(Color.secondary.opacity(0.65))
                                .frame(width: 65, height: 65)
                            
                            Text("+\(extraCount)")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        .transition(.scale.combined(with: .opacity))
                    }
                }
                .animation(.spring(response: 0.4, dampingFraction: 0.7), value: ingredientPhotoURLs.count)
            }
            
            Text(recipe.name)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
            
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
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background(.background)
        .cornerRadius(16)
        .shadow(color: .primary.opacity(0.05), radius: 8, x: 0, y: 8)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.primary, lineWidth: 0.4)
        )
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Recipe.self,
        configurations: config
    )

    let banana = Ingredient(barcode: "0001", name: "Banana", photoURL: "https://images.openfoodfacts.org/images/products/401/440/092/0063/front_en.400.jpg")
    let aveia = Ingredient(barcode: "0002", name: "Aveia", photoURL: "https://images.openfoodfacts.org/images/products/316/893/001/0007/front_en.400.jpg")
    let leite = Ingredient(barcode: "0003", name: "Leite", photoURL: "https://images.openfoodfacts.org/images/products/356/007/012/5074/front_en.400.jpg")
    let ovo = Ingredient(barcode: "0004", name: "Ovo", photoURL: "https://images.openfoodfacts.org/images/products/327/019/002/5503/front_en.400.jpg")
    let morango = Ingredient(barcode: "0005", name: "Morango", photoURL: "https://images.openfoodfacts.org/images/products/356/007/011/9508/front_en.400.jpg")
    let pastaAmendoim = Ingredient(barcode: "0006", name: "Pasta", photoURL: "https://images.openfoodfacts.org/images/products/001/111/000/0030/front_en.400.jpg")

    let sampleRecipe = Recipe(name: "Panqueca Proteica", tag: .breakfast)

    sampleRecipe.ingredients = [
        RecipeIngredient(userQuantity: 100, unity: .g, ingredient: banana, recipe: sampleRecipe),
        RecipeIngredient(userQuantity: 50, unity: .g, ingredient: aveia, recipe: sampleRecipe),
        RecipeIngredient(userQuantity: 100, unity: .ml, ingredient: leite, recipe: sampleRecipe),
        RecipeIngredient(userQuantity: 2, unity: .un, ingredient: ovo, recipe: sampleRecipe),
        RecipeIngredient(userQuantity: 50, unity: .g, ingredient: morango, recipe: sampleRecipe),
        RecipeIngredient(userQuantity: 20, unity: .g, ingredient: pastaAmendoim, recipe: sampleRecipe)
    ]

    return ScrollView {
        CardRecipe(recipe: sampleRecipe)
    }
    .modelContainer(container)
}
