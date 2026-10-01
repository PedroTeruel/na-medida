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
            } else if searchResults.isEmpty {
                Text("Busque um ingrediente")
                    .foregroundStyle(.secondary)
                    .listRowSeparator(.hidden)
            } else  {
                ForEach(searchResults, id: \.self) { product in
                    CardIngredient(
                        productName: product.productName ?? "Produto sem nome",
                        imageURL: product.fotoProdutoURL,
                        showActions: false,
                        onAdd: {
                            router.recipeSaveIngredient.append(product)
                            dismiss()
                            router.pop()
                        }
                    )
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Busque um ingrediente")
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
                    searchResults: [],
                    isLoading: false
                )
            }
        }
    }
    return PreviewContainer()
        .environment(Router())
}
