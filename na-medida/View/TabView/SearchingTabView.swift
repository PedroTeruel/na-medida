//
//  SearchTabView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 29/09/26.
//

import SwiftUI
import SwiftData

struct SearchingTabView: View {
    @Environment(Router.self) private var router
    @Environment(\.modelContext) private var mc
    
    @Query(sort: \Recipe.name) private var recipes: [Recipe]
    @Query(sort: \Ingredient.name) private var ingredients: [Ingredient]
    
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool
    
    private var filteredRecipes: [Recipe] {
        guard !searchText.isEmpty else { return [] }
        let lowerQuery = searchText.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        
        return recipes.filter { recipe in
            guard !recipe.isDeleted else { return false }
            
            return recipe.name.folding(options: .diacriticInsensitive, locale: .current).lowercased().contains(lowerQuery)
        }
    }
    
    private var filteredIngredients: [Ingredient] {
        guard !searchText.isEmpty else { return [] }
        let lowerQuery = searchText.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        
        return ingredients.filter { ingredient in
            guard !ingredient.isDeleted else { return false }
            
            let matchName = ingredient.name.folding(options: .diacriticInsensitive, locale: .current).lowercased().contains(lowerQuery)
            let matchBrand = ingredient.brand?.folding(options: .diacriticInsensitive, locale: .current).lowercased().contains(lowerQuery) ?? false
            
            return matchName || matchBrand
        }
    }
    
    var body: some View {
        @Bindable var routerBindable = router
        
        NavigationStack(path: $routerBindable.searchPath) {
            VStack(spacing: 0) {
                
                SearchBarComponent(
                    searchText: $searchText,
                    isSearchFocused: $isSearchFocused,
                    onSearchSubmit: { _ in
                        isSearchFocused = false
                    }
                )
                
                if searchText.isEmpty {
                    VStack(spacing: 16) {
                        Spacer()
                        Image("IconeSearch")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .opacity(0.6)
                        
                        Text("Busque por suas receitas criadas ou ingredientes salvos.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                        Spacer()
                    }
                } else if filteredRecipes.isEmpty && filteredIngredients.isEmpty {
                    VStack(spacing: 16) {
                        Spacer()
                        Image("IconeSearch")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                        
                        Text("Nenhum resultado encontrado para \"\(searchText)\".")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                        Spacer()
                    }
                } else {
                    List {
                        if !filteredRecipes.isEmpty {
                            Text("Receitas")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 16)
                                .padding(.top, 8)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets())
                            
                            ForEach(filteredRecipes) { recipe in
                                Button {
                                    isSearchFocused = false
                                    router.navigate(to: .recipesinfo(recipe))
                                } label: {
                                    CardRecipe(recipe: recipe)
                                }
                                .buttonStyle(.plain)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            }
                        }
                        
                        if !filteredIngredients.isEmpty {
                            Text("Ingredientes Salvos")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 16)
                                .padding(.top, filteredRecipes.isEmpty ? 8 : 24)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets())
                            
                            ForEach(filteredIngredients) { ingredient in
                                Button {
                                    isSearchFocused = false
                                    router.navigate(to: .savedIngredient(ingredient))
                                } label: {
                                    CardSheet(
                                        productName: ingredient.name,
                                        brand: ingredient.brand,
                                        quantity: ingredient.servingSize,
                                        imageURL: ingredient.photoURL
                                    )
                                }
                                .buttonStyle(.plain)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollDismissesKeyboard(.interactively)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: AppRoute.self) { route in
                router.build(route: route)
            }
        }
    }
}

#Preview {
    SearchingTabView()
        .environment(Router())
        .modelContainer(for: [Recipe.self, RecipeIngredient.self, Ingredient.self], inMemory: true)
}
