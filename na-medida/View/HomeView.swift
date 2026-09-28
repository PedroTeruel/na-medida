//
//  HomeView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        NavigationStack {
            VStack {
                NavigationLink("Criar Receita") {
                    RecipeView()
                }
            }
            .navigationTitle("Inicial")
        }
    }
}

#Preview {
    HomeView()
}
