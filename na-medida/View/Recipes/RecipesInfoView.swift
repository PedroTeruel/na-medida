//
//  RecipeView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI

struct RecipesInfoView: View {
    @Environment(Router.self) private var router
    @State private var showTagSheet = false
    
    var body: some View {
        
        VStack(spacing: 60) {
            
            Button {
                showTagSheet = true
            } label: {
                Image(systemName: "plus")
                Text("Tags")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                router.navigate(to: .scanner)
            } label: {
                Image(systemName: "plus")
                Text("Adicionar Ingrediente")
            }
            .buttonStyle(.bordered)
            
            Button {
                router.navigate(to: .ingredientinfo(nil))
            } label: {
                Image(systemName: "info.circle")
                Text("Informações dos Ingredientes")
            }
            .buttonStyle(.bordered)
            
        }
        .navigationTitle("Nova receita")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showTagSheet) {
            TagSheetView(
                cancelAction: {
                    showTagSheet = false
                },
                confirmAction: {
                    showTagSheet = false
                }
            )
        }
    }
}

#Preview {
    RecipesInfoView()
        .environment(Router())
}
