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
    @Environment(\.dismiss) private var dismiss
    
    var recipe: Recipe
    
    @State private var isShowingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                TagStatic(tag: recipe.tag)
                
                Text("Informações nutricionais totais")
                    .foregroundStyle(.secondary)
                    .padding(.top, 32)
                
                CarouselView(recipe: recipe)
                
                VStack {
                    Text("Adicione os ingredientes e as porções usadas na sua receita.")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                    
                    Button {
                        router.navigate(to: .scanner(recipe))
                    } label: {
                        AddIngredientButton()
                    }
                    .buttonStyle(.plain)
                    .padding(.top)
                    
                    if recipe.ingredients.isEmpty {
                        Text("")
                            .foregroundStyle(.secondary)
                    } else {
                        List {
                            ForEach(recipe.ingredients.reversed()) { recipeIng in
                                Button {
                                    if let ingredient = recipeIng.ingredient {
                                        router.navigate(to: .savedIngredient(ingredient))
                                    }
                                } label: {
                                    CardRecipeIngredient(
                                        productName: recipeIng.ingredient?.name,
                                        imageURL: recipeIng.ingredient?.photoURL,
                                        brands: recipeIng.ingredient?.brand,
                                        isEditable: false,
                                        userQuantity: .constant(recipeIng.userQuantity),
                                        unity: .constant(recipeIng.unity)
                                    )
                                }
                                .buttonStyle(.plain)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        deleteIngredient(recipeIng)
                                    } label: {
                                        Label("Excluir", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .listStyle(.plain)
                        .scrollDisabled(true)
                        .frame(height: CGFloat(recipe.ingredients.count) * 110)
                    }
                }
                .padding(.top, 32)
            }
            
            // texto de aviso
            Text("Lembre-se: as informações fornecidas pelo Na Medida são apenas uma estimativa e as fontes podem estar desatualizadas. ")
                .multilineTextAlignment(.leading)
                .foregroundStyle(.secondary)
                .fontWeight(.thin)
                .padding(.horizontal)
                .font(.footnote)
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
            
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        router.navigate(to: .editrecipe(recipe))
                    } label: {
                        Label("Editar", systemImage: "pencil")
                    }
                    
                    Button(role: .destructive) {
                        isShowingDeleteAlert = true
                    } label: {
                        Label("Excluir", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .alert("Excluir Receita?", isPresented: $isShowingDeleteAlert) {
            Button("Cancelar", role: .cancel) { }
            
            Button("Excluir", role: .destructive) {
                deleteRecipe()
            }
        } message: {
            Text("Tem certeza de que deseja excluir \"\(recipe.name)\"? Ela não poderá ser recuperada depois.")
        }
    }
    
    private func deleteRecipe() {
        mc.delete(recipe)
        dismiss()
    }
    
    private func deleteIngredient(_ recipeIngredient: RecipeIngredient) {
        withAnimation {
            if let index = recipe.ingredients.firstIndex(where: { $0.persistentModelID == recipeIngredient.persistentModelID }) {
                recipe.ingredients.remove(at: index)
                mc.delete(recipeIngredient)
                try? mc.save()
            }
        }
    }
}
    
    #Preview {
        NavigationStack {
            RecipesInfoView(recipe: Recipe(name: "Minha Receita", tag: .lunch))
            CardRecipeIngredient()
            
        }
        .environment(Router())
        .modelContainer(for: [Recipe.self, RecipeIngredient.self, Ingredient.self], inMemory: true)
    }
