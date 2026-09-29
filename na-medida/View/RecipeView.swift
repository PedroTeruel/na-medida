//
//  RecipeView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI

struct RecipeView: View {
    @Environment(Router.self) private var router
    
    var body: some View {
        
        VStack {            
            Button("Abrir Scanner") {
                router.navigate(to: .scanner)
            }
        }
        .navigationTitle("Nova receita")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    RecipeView()
        .environment(Router())
}
