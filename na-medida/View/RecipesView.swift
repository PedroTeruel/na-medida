//
//  HomeView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI

struct RecipesView: View {
    @Environment(Router.self) private var router
    
    var body: some View {
        @Bindable var routerBindable = router
        
        NavigationStack(path: $routerBindable.path) {
            VStack {
                
                Text("Nenhuma receita criada")
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        print("Filtro pressionado")
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                    Button {
                        router.navigate(to: .recipesinfo)
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
    RecipesView()
        .environment(Router())
}
