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
    @Environment(RecipeDraft.self) private var draft
    
    @FocusState private var isSearchFocused: Bool
    @State private var hasSearched: Bool = false
    
    @State private var showFeedback: Bool = false
    @State private var feedbackMessage: String = ""
    
    var searchResults: [ProductOpenFoodFactsDTO]
    var isLoading: Bool
    var onSearchSubmit: (String) -> Void
    
    private func showFeedbackToast(product: ProductOpenFoodFactsDTO) {
        let name = product.productName ?? "Ingrediente"
        let isTaco = product.brands?.uppercased().contains("TACO") ?? false
        
        let firstName: String
        if isTaco {
            firstName = name.trimmingCharacters(in: .whitespaces)
        } else {
            firstName = name.components(separatedBy: ["-", "–", "—"]).first?.trimmingCharacters(in: .whitespaces) ?? name
        }
        
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
                            
                            VStack(spacing: 0) {
                                
                                Image("IconeSearch")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                ProgressView()
                                    .controlSize(.large)
                                    .scaleEffect(0.5)
                                    .tint(.primary)
                                Text("Buscando")
                                    .fontWeight(.regular)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(3)
                            }
                            .frame(maxWidth: .infinity)
                            
                            
                            Spacer()
                        }
                        .padding(.top, 40)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        
                    } else if !searchText.isEmpty {
                        
                        if searchResults.isEmpty {
                            if hasSearched {
                                HStack(alignment: .center) {
                                    Spacer()
                                    VStack(spacing: 8) {
                                        Image("IconeSearch")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                        Text("Oops,")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.primary)
                                        Text("Nenhum produto encontrado para \"\(searchText)\". As vezes a pesquisa pode falhar. Tente novamente.")
                                            .fontWeight(.regular)
                                            .foregroundStyle(.secondary)
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(maxWidth: 280)
                                    Spacer()
                                }
                                .padding(.top, 40)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)

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
                                let isAlreadyAdd = draft.ingredients.contains(product)
                                
                                CardSheet(
                                    productName: product.productName ?? "Produto sem nome",
                                    brand: product.brands,
                                    quantity: product.servingSize,
                                    imageURL: product.photoProduct,
                                    isAdded: isAlreadyAdd,
                                    onAdd: {
                                        if !isAlreadyAdd {
                                            withAnimation(.spring()) {
                                                draft.addIngredient(product)
                                            }
                                            showFeedbackToast(product: product)
                                            searchText = ""
                                            isSearchFocused = false
                                        }
                                    }
                                )
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            }
                        }
                        
                    } else {
                        if draft.ingredients.isEmpty {
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
                            
                            ForEach(draft.ingredients, id: \.self) { product in
                                CardSheet(
                                    productName: product.productName ?? "Produto sem nome",
                                    brand: product.brands,
                                    quantity: product.servingSize,
                                    imageURL: product.photoProduct,
                                    onRemove: {
                                        draft.removeIngredient(product)
                                    }
                                )
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        draft.removeIngredient(product)
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
    struct PreviewWrapper: View {
        @State private var detent: PresentationDetent = .medium
        @State private var search = "Chocolate"
        
        var body: some View {
            SearchAPIView(
                currentDetent: $detent,
                searchText: $search,
                searchResults: [],
                isLoading: false,
                onSearchSubmit: { _ in }
            )
            .environment(Router())
            .environment(RecipeDraft())
        }
    }
    return PreviewWrapper()
}
