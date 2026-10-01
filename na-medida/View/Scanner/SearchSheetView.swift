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
    
    var body: some View {
        NavigationStack {
            SearchAPIView(
                currentDetent: $currentDetent,
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
        }
    }
    
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
}

#Preview {
    struct PreviewContainer: View {
        @State private var detent: PresentationDetent = .medium
        
        var body: some View {
            SearchSheetView(currentDetent: $detent)
        }
    }
    
    return PreviewContainer()
}
