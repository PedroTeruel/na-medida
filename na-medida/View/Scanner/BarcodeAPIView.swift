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
    @Environment(RecipeDraft.self) private var draft
    @Environment(\.modelContext) private var mc
    @Environment(OpenFoodFactsService.self) private var apiService
    
    @State private var showSheet = true
    @State private var sheetDetent: PresentationDetent = .fraction(0.3)
    @State private var scannerCode: String?
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showErrorAlert = false
    @State private var fetchTask: Task<Void, Never>?
    
    var recipe: Recipe? = nil
    
    var body: some View {
        ZStack {
            DataScanner(scannerCode: $scannerCode)
                .ignoresSafeArea()
            
            if isLoading {
                Color.black.opacity(0.5).ignoresSafeArea()
                
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
                Button(action: handleBackAction) {
                    HStack { Text("Voltar") }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: saveRecipeNavigate) {
                    Image(systemName: "checkmark")
                }
                .buttonStyle(.glassProminent)
                .disabled(draft.ingredients.isEmpty)
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
                .presentationDetents([.fraction(0.3), .medium, .large], selection: $sheetDetent)
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                .interactiveDismissDisabled()
                .presentationBackground(.background)
        }
        .alert("Atenção", isPresented: $showErrorAlert) {
            Button("Ok", role: .cancel) { scannerCode = nil }
        } message: {
            Text(errorMessage ?? "Erro")
        }
        .onDisappear {
            fetchTask?.cancel()
        }
    }
    
    private func handleBackAction() {
        fetchTask?.cancel()
        if showSheet {
            showSheet = false
            Task {
                try? await Task.sleep(for: .milliseconds(20))
                await MainActor.run {
                    router.pop()
                }
            }
        } else {
            router.pop()
        }
    }
    
    private func saveRecipeNavigate() {
        let repository = RecipeRepository(mc: mc)
        
        if let existingRecipe = recipe {
            repository.addIngredients(to: existingRecipe, dtos: draft.ingredients)
            draft.clear()
            handlePopTo(existing: true, recipe: existingRecipe)
        } else {
            let newRecipe = repository.saveRecipe(draft: draft)
            draft.clear()
            handlePopTo(existing: false, recipe: newRecipe)
        }
    }
    
    private func handlePopTo(existing: Bool, recipe: Recipe) {
        if showSheet {
            showSheet = false
            Task {
                try? await Task.sleep(for: .milliseconds(250))
                await MainActor.run {
                    existing ? router.pop() : router.navigate(to: .recipesinfo(recipe))
                }
            }
        } else {
            existing ? router.pop() : router.navigate(to: .recipesinfo(recipe))
        }
    }
    
    private func fetchProduct(barcode: String) {
        let descriptor = FetchDescriptor<Ingredient>(
            predicate: #Predicate { $0.barcode == barcode }
        )
        
        if let cachedIngredient = try? mc.fetch(descriptor).first {
            router.navigate(to: .savedIngredient(cachedIngredient))
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        fetchTask?.cancel()
        fetchTask = Task {
            do {
                let product = try await apiService.fetchProd(barcode: barcode)
                if Task.isCancelled { return }
                
                await handleSuccess(product)
            } catch OpenFoodFactsError.productNotFound {
                await MainActor.run {
                    showError("Produto não encontrado. Tente novamente ou pesquise.")
                }
            } catch {
                if !Task.isCancelled {
                    await MainActor.run {
                        showError("Erro: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    @MainActor
    private func showError(_ message: String) {
        isLoading = false
        errorMessage = message
        showErrorAlert = true
    }
    
    @MainActor
    private func handleSuccess(_ product: ProductOpenFoodFactsDTO) async {
        isLoading = false
        showSheet = false
        try? await Task.sleep(for: .milliseconds(200))
        router.navigate(to: .ingredientinfo(product))
    }
}

#Preview {
    BarcodeAPIView()
        .environment(Router())
        .modelContainer(for: [Recipe.self, RecipeIngredient.self, Ingredient.self], inMemory: true)
}
