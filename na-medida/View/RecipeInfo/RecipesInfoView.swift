//
//  RecipesInfoView.swift
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
    
    @State private var isShowingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                headerSection
                ingredientsSection
            }
            
            footerSection
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            toolbarActions
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
    
    
    private var headerSection: some View {
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
        }
    }
    
    @ViewBuilder
    private var ingredientsSection: some View {
        VStack {
            Text("Adicione ingredientes e porções da receita.")
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
            
            if !recipe.ingredients.isEmpty {
                List {
                    ForEach(recipe.ingredients.reversed()) { recipeIng in
                        RecipeIngredientRowView(
                            recipeIngredient: recipeIng,
                            router: router,
                            onDelete: {
                                deleteIngredient(recipeIng)
                            }
                        )
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
    
    private var footerSection: some View {
        Text("Lembre-se: as informações fornecidas pelo Na Medida são apenas uma estimativa e as fontes podem estar desatualizadas. ")
            .multilineTextAlignment(.leading)
            .foregroundStyle(.secondary)
            .font(.footnote)
            .fontWeight(.thin)
            .padding(.horizontal)
            .padding(.top)
    }
    
    @ToolbarContentBuilder
    private var toolbarActions: some ToolbarContent {
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
        
    private func deleteRecipe() {
        let repository = RecipeRepository(mc: mc)
        repository.deleteRecipe(recipe)
        router.popToRoot()
    }
    
    private func deleteIngredient(_ recipeIngredient: RecipeIngredient) {
        let repository = RecipeRepository(mc: mc)
        withAnimation {
            repository.removeIngredient(recipeIngredient, from: recipe, saveImmediately: true)
        }
    }
}

private struct RecipeIngredientRowView: View {
    let recipeIngredient: RecipeIngredient
    let router: Router
    let onDelete: () -> Void
    
    var body: some View {
        Button {
            if let ingredient = recipeIngredient.ingredient {
                router.navigate(to: .savedIngredient(ingredient))
            }
        } label: {
            CardRecipeIngredient(
                productName: recipeIngredient.ingredient?.name,
                imageURL: recipeIngredient.ingredient?.photoURL,
                isEditable: false,
                userQuantity: .constant(recipeIngredient.userQuantity),
                unity: .constant(recipeIngredient.unity)
            )
        }
        .buttonStyle(.plain)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button("Excluir", systemImage: "trash", role: .destructive) {
                onDelete()
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
