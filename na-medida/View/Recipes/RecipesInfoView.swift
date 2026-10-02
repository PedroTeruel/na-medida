//
//  RecipeView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI
import SwiftData

struct RecipesInfoView: View {
    @Environment(Router.self) private var router
    @Environment(\.modelContext) private var mc
    
    var recipe: Recipe
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 60) {
                Button {
                    router.navigate(to: .scanner)
                } label: {
                    AddIngredientButton()
                }
                .buttonStyle(.plain)
                
                VStack {
                    if recipe.ingredients.isEmpty {
                        Text("Nenhum ingrediente adicionado")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(recipe.ingredients) { recipeIng in
                            CardRecipeIngredient(
                                productName: recipeIng.ingredient?.name,
                                imageURL: recipeIng.ingredient?.photoURL,
                                brands: recipeIng.ingredient?.brand)
                        }
                    }
                }
            }
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.popToRoot()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
    }
    
    private func saveRecipeSwiftData() {
        let repository = RecipeRepository(mc: mc)
        
        let newRecipe = repository.saveRecipe(
            title: router.draftTitle,
            tag: router.draftTag,
            dtoIngredients: router.recipeSaveIngredient)
        
        router.clearDraft()
        router.navigate(to: .recipesinfo(newRecipe))
    }
}

//#Preview {
//    NavigationStack {
//        RecipesInfoView(recipe: Recipe)
//            .environment(Router())
//            .modelContainer()
//    }
//}
