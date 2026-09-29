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
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
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
        .sheet(isPresented: $showSheet) {
            SearchSheetView(currentDetent: $sheetDetent)
                .presentationDetents([.fraction(0.4), .medium, .large], selection: $sheetDetent)
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                .interactiveDismissDisabled()
        }
    }
}

#Preview {
    BarcodeAPIView()
        .environment(Router())
}
