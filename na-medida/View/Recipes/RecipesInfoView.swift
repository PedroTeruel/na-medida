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
        
        ScrollView {
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
                    AddIngredientButton()
                }
                .buttonStyle(.plain)
                
                Button {
                    router.navigate(to: .ingredientinfo(nil))
                } label: {
                    Image(systemName: "info.circle")
                    Text("Informações dos Ingredientes")
                }
                .buttonStyle(.bordered)

                
                VStack {
                    if router.recipeSaveIngredient.isEmpty {
                        Text("")
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
