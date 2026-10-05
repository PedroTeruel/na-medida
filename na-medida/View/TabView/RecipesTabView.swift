//
//  HomeView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftData
import SwiftUI

struct RecipesTabView: View {
    @Environment(Router.self) private var router
    @Environment(\.modelContext) private var mc
    @Query private var recipes: [Recipe]
    @State private var selectedTag: RecipeTag? = nil
    //@State private var anyRecipe: Recipe = nil
    
//    private var hasRecipe: [Recipe]{
//        guard let anyRecipe
//                else{
//            return bool
//        }
//    }
    private var filteredRecipes: [Recipe]{
        guard let selectedTag
        else {
            return recipes
        }
        return recipes.filter { recipe in
            recipe.tag == selectedTag
        }
    }
    
    let username: String
    
    var body: some View {
        @Bindable var routerBindable = router
        
        NavigationStack(path: $routerBindable.recipesPath) {
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 22){
                    Text("O que vamos preparar hoje?")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Text("Suas Receitas")
                        .foregroundStyle(.primary)
                        .font(.title2)
                        .fontWeight(.semibold)
                }.padding(.horizontal)
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
                    .padding(.horizontal, 16)
                }
                ScrollView {
                    VStack {
                        if recipes.isEmpty {
                            Text("Nenhuma receita criada")
                        } else {
                            ForEach(recipes) { recipe in
                                Button {
                                    router.navigate(to: .recipesinfo(recipe))
                                } label: {
                                    CardRecipe(recipe: recipe)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .navigationTitle("Olá, \(username)")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            print("Filtro pressionado")
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
