//
//  RecipeIngredientImageView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 02/10/26.
//

import SwiftUI

struct RecipeIngredientImageView: View {
    
    let urlString: String
    
    var body: some View {
        
        AsyncProductImage(urlString: urlString, size: 70, cornerRadius: 35)
            .overlay(Circle().stroke(Color.white, lineWidth: 3))
    }
}

#Preview {
    RecipeIngredientImageView(urlString: "")
}
