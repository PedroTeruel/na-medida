//
//  HomeView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftData
import SwiftUI

struct RecipesTabView: View {
//    @State private var showNewRecipeSheet = false
    @Environment(Router.self) private var router
    @Environment(\.modelContext) private var mc
    
    var body: some View {
        @Bindable var routerBindable = router
        
        NavigationStack(path: $routerBindable.path) {
            VStack {
                
                Text("Nenhuma receita criada")
                
            }
//            .sheet(isPresented: $showNewRecipeSheet) {
//                NewRecipeSheet { title, tag in
//                    print(title)
//                    print(tag)
//                }
//            }
//            .sheet(isPresented: $showNewRecipeSheet) {
//                NavigationStack {
//                    NewRecipeView { title, tag in
//                        
//                        let newRecipe = Recipe(
//                            name: title,
//                            tag: tag
//                        )
//                        
//                        showNewRecipeSheet = false
//                        
//                        mc.insert(newRecipe)
//                        
//                        router.navigate(to: .recipesinfo)
//                    }
//                }
//            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        print("Filtro pressionado")
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                    Button {
//                        showNewRecipeSheet = true
                       router.navigate(to: .newrecipe)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.glassProminent)
                    .tint(.button)
                }
            }
            .navigationTitle("Olá, William!")
            .navigationDestination(for: AppRoute.self) { route in
                router.build(route: route)
            }
        }
    }
}

#Preview {
    RecipesTabView()
        .environment(Router())
}
