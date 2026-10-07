//
//  HomeView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftData
import SwiftUI

enum SortOrder {
    case newest
    case oldest
}

struct RecipesTabView: View {
    @Environment(Router.self) private var router
    @Environment(\.modelContext) private var mc
    @Query private var recipes: [Recipe]
    @State private var selectedTag: RecipeTag? = nil
    @State private var sortOrder: SortOrder = .newest
    
    private var filteredRecipes: [Recipe] {
        let filtered: [Recipe]

        if let selectedTag {
            filtered = recipes.filter { recipe in
                recipe.tag == selectedTag
            }
        } else {
            filtered = recipes
        }

        switch sortOrder {
        case .newest:
            return filtered.sorted { (recipe1: Recipe, recipe2: Recipe) -> Bool in
                recipe1.creationDate > recipe2.creationDate
            }

        case .oldest:
            return filtered.sorted { (recipe1: Recipe, recipe2: Recipe) -> Bool in
                recipe1.creationDate < recipe2.creationDate
            }
        }
    }
    
    let username: String
    
    var body: some View {
        @Bindable var routerBindable = router
        
        NavigationStack(path: $routerBindable.recipesPath) {
            ScrollView{
                VStack(alignment: .leading){
                    VStack(alignment: .leading, spacing: 36){
                        Text("Pronto para registrar uma receita?")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        if recipes.isEmpty{
                            Spacer()
                        } else{
                            Text("Suas Receitas")
                                .foregroundStyle(.primary)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                    }
                    .padding(.horizontal, 16)
                    
                    if recipes.isEmpty {
                        VStack(alignment: .center){
                            Spacer()
                            Text(recipes.isEmpty ? "Nenhuma receita criada" : "Nenhuma receita nessa categoria")
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        VStack(alignment: .leading){
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 10){
                                    ForEach(RecipeTag.allCases, id:\.self) { tag in
                                        TagButton(
                                            tag: tag,
                                            title: tag.rawValue,
                                            isSelected: selectedTag == tag
                                        ){
                                            if selectedTag == tag {
                                                selectedTag = nil
                                            } else {
                                                selectedTag = tag
                                            }
                                        }
                                    }
                                }
                                .padding(.bottom, 8)
                                .padding(.horizontal, 16)
                            }
                            ScrollView {
                                VStack {
                                    ForEach(filteredRecipes) { recipe in
                                        Button {
                                            router.navigate(to: .recipesinfo(recipe))
                                        } label: {
                                            CardRecipe(recipe: recipe)
                                        }
                                        .buttonStyle(.plain)
                                        .padding(.vertical, 4)
                                    }
                                }
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .navigationTitle("Olá, \(username)!")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Menu {
                            Picker("Ordenar por", selection: $sortOrder) {
                                Text("Mais recentes")
                                    .tag(SortOrder.newest)
                                
                                Text("Mais antigas")
                                    .tag(SortOrder.oldest)
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                        }
                        Button {
                            router.navigate(to: .newrecipe)
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.glassProminent)
                        .tint(.button)
                    }
                }
                .navigationDestination(for: AppRoute.self) { route in
                    router.build(route: route)
                }
            }
        }
    }
}

#Preview {
    RecipesTabView(username: "Will")
        .environment(Router())
        .modelContainer(for: [Recipe.self, RecipeIngredient.self, Ingredient.self], inMemory: true)
}
