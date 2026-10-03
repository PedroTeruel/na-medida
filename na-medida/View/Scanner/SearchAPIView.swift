//
//  SearchAPIView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 29/09/26.
//

import SwiftUI

struct SearchAPIView: View {
    @Binding var currentDetent: PresentationDetent
    @Environment(\.isSearching) private var isSearching
    
    @Environment(Router.self) private var router
    @Environment(\.dismiss) private var dismiss
    
    var searchText: String
    var searchResults: [ProductOpenFoodFactsDTO]
    var isLoading: Bool
    
    var body: some View {
        
        List {
            if isLoading {
                HStack {
                    Spacer()
                    ProgressView("Buscando...")
                    Spacer()
                }
                listRowSeparator(.hidden)
                
            } else if !searchText.isEmpty {
                
                if searchResults.isEmpty {
                    Text("Nenhum produto encontrado para \"\(searchText)\".")
                        .foregroundStyle(.secondary)
                        .listRowSeparator(.hidden)
                    
                } else {
                    Text("Resultados")
                    ForEach(searchResults, id: \.self) { product in
                        CardIngredient(
                            productName: product.productName ?? "Produto sem nome",
                            brand: product.brands,
                            quantity: product.servingSize,
                            imageURL: product.fotoProdutoURL,
                            onAdd: {
                                if !router.recipeSaveIngredient.contains(product) {
                                    router.recipeSaveIngredient.append(product)
                                }
                            }
                        )
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    }
                }
                
            } else {
                if router.recipeSaveIngredient.isEmpty {
                    HStack {
                        Spacer()
                        SearchIconComponent()
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    
                } else {
                    Text("Ingredientes adicionados")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    ForEach(router.recipeSaveIngredient, id: \.self) { product in
                        CardIngredient(
                            productName: product.productName ?? "Produto sem nome",
                            brand: product.brands,
                            quantity: product.servingSize,
                            imageURL: product.fotoProdutoURL,
                            onRemove: {
                                if let index = router.recipeSaveIngredient.firstIndex(of: product) {
                                    router.recipeSaveIngredient.remove(at: index)
                                }
                            }
                        )
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                if let index = router.recipeSaveIngredient.firstIndex(of: product) {
                                    router.recipeSaveIngredient.remove(at: index)
                                }
                            } label: {
                                Label("Remover", systemImage: "trash")
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Buscar")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: isSearching) { _, isFocused in
            if isFocused {
                currentDetent = .large
            }
        }
    }
}

#Preview {
    struct PreviewContainer: View {
        @State private var detent: PresentationDetent = .medium
        
        var body: some View {
            NavigationStack {
                SearchAPIView(
                    currentDetent: $detent,
                    searchText: "",
                    searchResults: [],
                    isLoading: false
                )
            }
        }
    }
    return PreviewContainer()
        .environment(Router())
}
