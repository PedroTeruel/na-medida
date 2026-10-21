//
//  SearchAPIView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 29/09/26.
//

import SwiftUI

struct SearchAPIView: View {
    @Binding var currentDetent: PresentationDetent
    
    @Environment(RecipeDraft.self) private var draft
    @Environment(OpenFoodFactsService.self) private var apiService
    @Environment(TacoService.self) private var tacoService
    
    @FocusState private var isSearchFocused: Bool
    @State private var searchText: String = ""
    @State private var searchResults: [ProductOpenFoodFactsDTO] = []
    @State private var isLoading: Bool = false
    @State private var hasSearched: Bool = false
    @State private var searchTask: Task<Void, Never>?
    
    @State private var showFeedback: Bool = false
    @State private var feedbackMessage: String = ""
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                SearchBarComponent(
                    searchText: $searchText,
                    isSearchFocused: $isSearchFocused,
                    onSearchSubmit: { query in
                        hasSearched = true
                        performSearch(query: query)
                    }
                )
                
                List {
                    if isLoading {
                        loadingView
                    } else if !searchText.isEmpty {
                        if searchResults.isEmpty {
                            if hasSearched {
                                emptyResultsView
                            }
                        } else {
                            searchResultsList
                        }
                    } else {
                        addedIngredientsList
                    }
                }
                .listStyle(.plain)
                .scrollDismissesKeyboard(.interactively)
            }
            
            if showFeedback {
                feedbackToastView
            }
        }
        .onChange(of: isSearchFocused) { _, isFocused in
            if isFocused {
                currentDetent = .fraction(0.92)
            }
        }
        .onChange(of: searchText) { _, newValue in
            hasSearched = false
            if newValue.isEmpty {
                searchTask?.cancel()
                searchResults.removeAll()
                isLoading = false
            }
        }
        .onDisappear {
            searchTask?.cancel()
        }
    }
    
    private func performSearch(query: String) {
        guard !query.isEmpty else { return }
        
        isLoading = true
        searchTask?.cancel()
        
        searchTask = Task {
            let tacoResults = tacoService.searchProducts(query: query)
            do {
                await MainActor.run {
                    self.searchResults = tacoResults
                }
                
                let apiResults = try await apiService.searchProducts(query: query)
                
                if Task.isCancelled { return }
                
                await MainActor.run {
                    self.searchResults = apiResults + tacoResults
                    self.isLoading = false
                }
            } catch {
                if Task.isCancelled { return }
                
                print("Erro ao buscar produtos: \(error)")
                await MainActor.run {
                    self.searchResults = tacoResults
                    self.isLoading = false
                }
            }
        }
    }
        
    private var loadingView: some View {
        HStack {
            Spacer()
            VStack(spacing: 12) {
                Image("IconeSearch")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                ProgressView()
                    .controlSize(.large)
                    .scaleEffect(0.5)
                    .tint(.primary)
                Text("Buscando...")
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                Text("A busca pode levar alguns segundos devido à alta demanda.")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: 250)
            Spacer()
        }
        .padding(.top, 40)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
    
    private var emptyResultsView: some View {
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
    
    @ViewBuilder
    private var searchResultsList: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Resultado da pesquisa '\(searchText)'")
                .font(.headline)
            Spacer()
            Text("\(searchResults.count) resultados encontrados.")
                .font(.subheadline)
                .foregroundStyle(.primary)
            Text("Caso não encontre o item desejado. Tente novamente.")
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
        .listRowSeparator(.hidden)
        
        ForEach(searchResults, id: \.self) { product in
            let isAlreadyAdd = draft.ingredients.contains(product)
            
            CardSheet(
                productName: product.cleanProductName,
                brand: product.cleanBrand,
                quantity: product.quantity ?? product.servingSize,
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
    
    @ViewBuilder
    private var addedIngredientsList: some View {
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
                CardRecipeIngredient(
                    productName: product.cleanProductName,
                    imageURL: product.photoProduct,
                    isEditable: true,
                    userQuantity: quantityBinding(for: product),
                    unity: unitBinding(for: product),
                    defaultUnit: product.defaultServing.unit,
                    onRemove: {
                        draft.removeIngredient(product)
                    }
                )
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
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
    
    private var feedbackToastView: some View {
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
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .zIndex(1)
    }
    
    private func showFeedbackToast(product: ProductOpenFoodFactsDTO) {
        feedbackMessage = "\(product.cleanProductName) adicionado!"
        
        withAnimation(.spring()) {
            showFeedback = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut) {
                showFeedback = false
            }
        }
    }
    
    private func quantityBinding(for product: ProductOpenFoodFactsDTO) -> Binding<Double> {
        Binding(
            get: { draft.quantities[product] ?? product.defaultServing.quantity },
            set: { newValue in draft.quantities[product] = newValue }
        )
    }
    
    private func unitBinding(for product: ProductOpenFoodFactsDTO) -> Binding<QntUnity> {
        Binding(
            get: { draft.units[product] ?? product.defaultServing.unit },
            set: { newValue in draft.units[product] = newValue }
        )
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var detent: PresentationDetent = .medium
        
        var body: some View {
            SearchAPIView(currentDetent: $detent)
                .environment(RecipeDraft())
                .environment(OpenFoodFactsService())
                .environment(TacoService())
        }
    }
    return PreviewWrapper()
}
