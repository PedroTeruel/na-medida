//
//  ScannerView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI
import SwiftData

struct BarcodeAPIView: View {
    @Environment(Router.self) private var router
    @Environment(\.modelContext) private var mc
    
    @State private var showSheet = true
    @State private var sheetDetent: PresentationDetent = .fraction(0.4)
    
    //API
    @State private var scannerCode: String?
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showErrorAlert = false
    
    private let apiService = OpenFoodFactsService()
    
    
    var body: some View {
        ZStack {
            DataScanner(scannerCode: $scannerCode)
                .ignoresSafeArea()
            
            if isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                VStack {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(1.5)
                    Text("Buscando produto...")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if showSheet {
                        showSheet = false
                        
                        Task {
                            try? await Task.sleep(for: .milliseconds(20))
                            router.pop()
                        }
                    } else {
                        router.pop()
                    }
                } label: {
                    HStack {
                        Text("Voltar")
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    saveRecipeNavigate()
                } label: {
                    Image(systemName: "checkmark")
                }
                .buttonStyle(.glassProminent)
                .disabled(router.recipeSaveIngredient.isEmpty)
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .onChange(of: scannerCode) { _, newCode in
            if let code = newCode, !isLoading {
                fetchProduct(barcode: code)
            }
        }
        .sheet(isPresented: $showSheet) {
            SearchSheetView(currentDetent: $sheetDetent)
                .presentationDetents([.fraction(0.4), .medium, .large], selection: $sheetDetent)
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                .interactiveDismissDisabled()
        }
        .alert("Atenção", isPresented: $showErrorAlert) {
            Button("Ok", role: .cancel) {
                scannerCode = nil
            }
        } message: {
            Text(errorMessage ?? "Erro")
        }
    }
    
    
    private func saveRecipeNavigate() {
        let repository = RecipeRepository(mc: mc)
        
        let newRecipe = repository.saveRecipe(
            title: router.draftTitle,
            tag: router.draftTag,
            dtoIngredients: router.recipeSaveIngredient)
        
        router.clearDraft()
        
        if showSheet {
            showSheet = false
            Task {
                try? await Task.sleep(for: .milliseconds(250))
                await MainActor.run {
                    router.navigate(to: .recipesinfo(newRecipe))
                }
            }
        } else {
            router.navigate(to: .recipesinfo(newRecipe))
        }
    }
    
    
    
    private func fetchProduct(barcode: String) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let product = try await apiService.fetchProd(barcode: barcode)
                
                await MainActor.run {
                    isLoading = false
                    showSheet = false
                }
                try? await Task.sleep(for: .milliseconds(200))
                
                await MainActor.run {
                    router.navigate(to: .ingredientinfo(product))
                }
            } catch OpenFoodFactsError.productNotFound {
                print("Produto não encontrado no banco de dados.")
                showError("Produto não encontrado. Tente novamente ou pequise na barra de busca")
            } catch {
                print("Detalhes do Erro: \(error)")
                showError("Erro: \(error.localizedDescription)")
            }
        }
    }
    
    @MainActor
    private func showError(_ message: String) {
        isLoading = false
        errorMessage = message
        showErrorAlert = true
    }
}

#Preview {
    BarcodeAPIView()
        .environment(Router())
        .modelContainer(for: [Recipe.self, RecipeIngredient.self, Ingredient.self], inMemory: true)
}

