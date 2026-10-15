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
    case fromA
    case fromZ
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
        case .fromA:
            return filtered.sorted { (recipe1: Recipe, recipe2: Recipe) -> Bool in
                recipe1.name.localizedStandardCompare(recipe2.name) == .orderedAscending
            }
            
        case .fromZ:
            return filtered.sorted { (recipe1: Recipe, recipe2: Recipe) -> Bool in
                recipe1.name.localizedStandardCompare(recipe2.name) == .orderedDescending
            }
            
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
                        Text("Pronto para registrar suas receitas?")
                            .font(.callout)
                            .foregroundStyle(.primary)
                        
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
                            
                            Image("iconeOnBoard").resizable().scaledToFit()
                                .frame( height: 120)
                            
                            Text(recipes.isEmpty ? "Ainda não há nenhuma receita registrada" : "Nenhuma receita nessa categoria")
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .padding()
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
                            
                            List {
                                ForEach(filteredRecipes) { recipe in
                                    Button {
                                        router.navigate(to: .recipesinfo(recipe))
                                    } label: {
                                        CardRecipe(recipe: recipe)
                                    }
                                    .buttonStyle(.plain)
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                                    .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            deleteRecipe(recipe)
                                        } label: {
                                            Label("Deletar", systemImage: "trash")
                                        }
                                    }
                                }
                            }
                            .listStyle(.plain)
                            .scrollDisabled(true)
                            .frame(height: CGFloat(filteredRecipes.count) * 220)
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
                                Text("Ordem Alfabetica Crescente (A-Z)")
                                    .tag(SortOrder.fromA)
                                
                                Text("Ordem Alfabetica Decrescente (Z-A)")
                                    .tag(SortOrder.fromZ)
                                
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
    private func deleteRecipe(_ recipe: Recipe) {
        withAnimation {
            mc.delete(recipe)
        }
    }
}


#Preview {
    RecipesTabView(username: "Will")
        .environment(Router())
        .modelContainer(for: [Recipe.self, RecipeIngredient.self, Ingredient.self], inMemory: true)
}
