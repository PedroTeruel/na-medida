//
//  SearchAPIView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 29/09/26.
//

import SwiftUI

struct SearchAPIView: View {
    @Binding var currentDetent: PresentationDetent
    @Binding var searchText: String
    
    @Environment(Router.self) private var router
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var isSearchFocused: Bool
    @State private var hasSearched: Bool = false
    
    @State private var showFeedback: Bool = false
    @State private var feedbackMessage: String = ""
    
    var searchResults: [ProductOpenFoodFactsDTO]
    var isLoading: Bool
    var onSearchSubmit: (String) -> Void
    
    private func showFeedbackToast(productName: String?) {
        let name = productName ?? "Ingrediente"
        let firstName = name.components(separatedBy: ["-", "–", "—"]).first?.trimmingCharacters(in: .whitespaces) ?? name
        
        feedbackMessage = "\(firstName) adicionado!"
        
        withAnimation(.spring()) {
            showFeedback = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut) {
                showFeedback = false
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                SearchBarComponent(
                    searchText: $searchText,
                    isSearchFocused: $isSearchFocused,
                    onSearchSubmit: { query in
                        hasSearched = true
                        onSearchSubmit(query)
                    }
                )
                
                List {
                    if isLoading {
                        HStack {
                            Spacer()
                            ProgressView("Buscando...")
                            Spacer()
                        }
                        .listRowSeparator(.hidden)
                        
                    } else if !searchText.isEmpty {
                        
                        if searchResults.isEmpty {
                            if hasSearched {
                                Text("Nenhum produto encontrado para \"\(searchText)\".")
                                    .foregroundStyle(.secondary)
                                    .listRowSeparator(.hidden)
                            }
                            
                            
                            
                        } else {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Resultado da pesquisa '\(searchText)'")
                                    .font(.headline)
                                Spacer()
                                Text("\(searchResults.count) produtos encontrados")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .listRowSeparator(.hidden)
                            
                            ForEach(searchResults, id: \.self) { product in
                                let isAlreadyAdd = router.recipeSaveIngredient.contains(product)
                                
                                CardIngredient(
                                    productName: product.productName ?? "Produto sem nome",
                                    brand: product.brands,
                                    quantity: product.servingSize,
                                    imageURL: product.fotoProdutoURL,
                                    isAdded: isAlreadyAdd,
                                    onAdd: {
                                        if !isAlreadyAdd {
                                            withAnimation(.spring()) {
                                                router.recipeSaveIngredient.append(product)
                                            }
                                            showFeedbackToast(productName: product.productName)
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
                                .listRowSeparator(.hidden)
                            
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
                .scrollDismissesKeyboard(.interactively)
            }
            
            if showFeedback {
                Text(feedbackMessage)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.green.opacity(0.9))
                    .clipShape(Capsule())
                    .shadow(radius: 5)
                    .padding(.top, 24)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
            }
        }
        .onChange(of: isSearchFocused) { _, isFocused in
            if isFocused {
                currentDetent = .large
            }
        }
        .onChange(of: searchText) { _, _ in
            hasSearched = false
        }
    }
}

#Preview {
    struct PreviewContainer: View {
        @State private var detent: PresentationDetent = .medium
        @State private var text = ""
        
        var body: some View {
            SearchAPIView(
                currentDetent: $detent,
                searchText: $text,
                searchResults: [],
                isLoading: false,
                onSearchSubmit: { _ in }
            )
        }
    }
    return PreviewContainer()
        .environment(Router())
}
