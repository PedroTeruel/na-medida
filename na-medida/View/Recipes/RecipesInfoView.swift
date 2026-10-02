//
//  RecipeView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI

struct RecipesInfoView: View {
    @Environment(Router.self) private var router
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 60) {
                
                Button {
                    router.navigate(to: .scanner)
                } label: {
                    AddIngredientButton()
                }
                .buttonStyle(.plain)
                
                VStack {
                    if router.recipeSaveIngredient.isEmpty {
                        Text("Nenhum ingrediente adicionado")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(router.recipeSaveIngredient, id: \.self) { product in
                            CardRecipeIngredient(
                                productName: product.productName,
                                imageURL: product.fotoProdutoURL,
                                brands: product.brands)
                        }
                    }
                }
            }
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Nova receita")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.popToRoot()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipesInfoView()
            .environment(Router())
    }
}
