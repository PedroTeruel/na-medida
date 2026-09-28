//
//  RecipeView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI

struct RecipeView: View {
    var body: some View {
        
        VStack {            
            NavigationLink("Abrir Scanner") {
                ScannerView()
            }
        }
        .navigationTitle("Nova receita")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}
