//
//  SearchSheetView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 29/09/26.
//

import SwiftUI

struct SearchSheetView: View {
    
    @Environment(OpenFoodFactsService.self) private var apiService
    
    @State private var searchField = ""
    @Binding var currentDetent: PresentationDetent
    
    @State private var searchResults: [ProductOpenFoodFactsDTO] = []
    @State private var isLoading = false
    @State private var searchTask: Task<Void, Never>?
    
    private func performSearch(query: String) {
        guard !query.isEmpty else { return }
        
        isLoading = true
        searchTask?.cancel()
        
        searchTask = Task {
            do {
                let results = try await apiService.searchProducts(query: query)
                
                if Task.isCancelled { return }
                
                await MainActor.run {
                    self.searchResults = results
                    self.isLoading = false
                }
            } catch {
                if Task.isCancelled { return }
                
                print("Erro ao buscar produtos: \(error)")
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }
    
    var body: some View {
        SearchAPIView(
            currentDetent: $currentDetent,
            searchText: $searchField,
            searchResults: searchResults,
            isLoading: isLoading,
            onSearchSubmit: { query in
                performSearch(query: query)
            }
        )
        .onChange(of: searchField) { _, newValue in
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
}
