//
//  BarcodeAPIView.swift
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
    @State private var fetchTask: Task<Void, Never>?
    
    var recipe: Recipe? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
            DataScanner(scannerCode: $scannerCode)
                .ignoresSafeArea()
            
            if let errorMsg = errorMessage {
                Text(errorMsg)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.red.opacity(0.9))
                    .clipShape(Capsule())
                    .shadow(radius: 5)
                    .padding(.top, 16)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(2)
            }
            
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
                .zIndex(1)
            }
        }
        .navigationTitle("Adicione ingredientes")
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
                .foregroundStyle(.white)
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
        isLoading = true
        // Esconde erro anterior, se houver
        withAnimation { errorMessage = nil }
        
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
        
        withAnimation(.spring()) {
            errorMessage = message
        }
        
        Task {
            try? await Task.sleep(for: .seconds(3))
            withAnimation(.easeInOut) {
                self.errorMessage = nil
            }
            self.scannerCode = nil
        }
    }
    
    @MainActor
    private func handleSuccess(_ product: ProductOpenFoodFactsDTO) async {
        isLoading = false
        withAnimation { errorMessage = nil }
        
        if !draft.ingredients.contains(product) {
            withAnimation(.spring()) {
                draft.addIngredient(product)
            }
        }
        
        if sheetDetent == .fraction(0.3) {
            sheetDetent = .medium
        }
        
        scannerCode = nil
    }
}

#Preview {
    BarcodeAPIView()
        .environment(Router())
        .environment(RecipeDraft())
        .environment(OpenFoodFactsService())
        .modelContainer(for: [Recipe.self, RecipeIngredient.self, Ingredient.self], inMemory: true)
}
