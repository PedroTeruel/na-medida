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
            Text(recipe.name)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            TagStatic(tag: recipe.tag)
            
            Text("Informações nutricionais totais")
                .foregroundStyle(.secondary)
                .padding(.top, 32)
            
            VStack(spacing: 40) {
                CarouselView(recipe: recipe)
            }
            
            VStack {
                Button {
                    router.navigate(to: .scanner(recipe))
                } label: {
                    AddIngredientButton()
                }
                .buttonStyle(.plain)
                .padding(.top, 32)
                
                VStack {
                    if recipe.ingredients.isEmpty {
                        Text("Nenhum ingrediente adicionado")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(recipe.ingredients.reversed()) { recipeIng in
                            Button {
                                if let ingredient = recipeIng.ingredient{
                                    router.navigate(to: .savedIngredient(ingredient))
                                }
                            } label: {
                                
                                CardRecipeIngredient(
                                    productName: recipeIng.ingredient?.name,
                                    imageURL: recipeIng.ingredient?.photoURL,
                                    brands: recipeIng.ingredient?.brand)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("")
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
            ToolbarItem {
                Button {
                    print("Menu")
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipesInfoView(recipe: Recipe(name: "Minha Receita", tag: .lunch))
    }
    .environment(Router())
    .modelContainer(for: [Recipe.self, RecipeIngredient.self, Ingredient.self], inMemory: true)
}
