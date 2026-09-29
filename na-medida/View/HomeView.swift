//
//  HomeView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI

struct HomeView: View {
    @Environment(Router.self) private var router
    
    var body: some View {
        @Bindable var routerBindable = router
        
        NavigationStack(path: $routerBindable.path) {
            VStack {
                Button("Criar Receita") {
                    router.navigate(to: .recipe)
                }
            }
            .navigationTitle("Inicial")
            .navigationDestination(for: AppRoute.self) { route in
                router.build(route: route)
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(Router())
}
