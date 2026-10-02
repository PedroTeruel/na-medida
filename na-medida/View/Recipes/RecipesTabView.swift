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
    
    let username: String
    
    var body: some View {
        @Bindable var routerBindable = router
        
        NavigationStack(path: $routerBindable.recipesPath) {
            ScrollView {
                VStack {
                    if recipes.isEmpty {
                        Text("Nenhuma receita criada")
                    } else {
                        ForEach(recipes) { recipe in
                            CardRecipe(recipe: recipe)
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
            .navigationTitle("Olá, \(username)!")
            .navigationDestination(for: AppRoute.self) { route in
                router.build(route: route)
            }
        }
    }

#Preview {
    RecipesTabView(username: "Will")
        .environment(Router())
}
