//
//  SearchSheetView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 29/09/26.
//

import SwiftUI

struct SearchSheetView: View {
    
    @State private var searchField = ""
    @Binding var currentDetent: PresentationDetent
    
    //API
    @State private var searchResults: [ProductOpenFoodFactsDTO] = []
    @State private var isLoading = false
    private let apiService = OpenFoodFactsService()
    //
    
    private func performSearch() {
        guard !searchField.isEmpty else { return }
        
        isLoading = true
        Task {
            do {
                let results = try await apiService.searchProducts(query: searchField)
                
                await MainActor.run {
                    self.searchResults = results
                    self.isLoading = false
                }
            } catch {
                print("Erro ao buscar produtos: \(error)")
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            SearchAPIView(
                currentDetent: $currentDetent,
                searchText: searchField,
                searchResults: searchResults,
                isLoading: isLoading
            )
            .searchable(
                text: $searchField,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Pesquisar ingrediente"
            )
            .onSubmit(of: .search) {
                performSearch()
            }
            .onChange(of: searchField) { _, newValue in
                if newValue.isEmpty {
                    searchResults.removeAll()
                }
            }
        }
    }
}
