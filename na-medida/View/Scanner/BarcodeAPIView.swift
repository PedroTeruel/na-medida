//
//  ScannerView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI

struct BarcodeAPIView: View {
    @Environment(Router.self) private var router
    @State private var showSheet = true
    @State private var sheetDetent: PresentationDetent = .fraction(0.4)
    
    //API
    @State private var scannerCode: String?
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    private let apiService = OpenFoodFactsService()
    
    var body: some View {
        ZStack {
            DataScanner(scannerCode: $scannerCode)
                .ignoresSafeArea()
            
            VStack {
            }
            
        }
        .navigationTitle("Scanner")
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
        }
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
    }
    
    private func fetchProduct(barcode: String) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let product = try await apiService.fetchProd(barcode: barcode)
                isLoading = false
                
                router.navigate(to: .ingredientinfo(product))
            } catch OpenFoodFactsError.productNotFound {
                showError("Produto não encontrado")
            } catch {
                showError("Erro na conexão.")
            }
        }
    }

    private func showError(_ message: String) {
        isLoading = false
        errorMessage = message
        
        Task {
            try? await Task.sleep(for: .seconds(3))
            scannerCode = nil
            errorMessage = nil
        }
    }
}

#Preview {
    BarcodeAPIView()
        .environment(Router())
}
