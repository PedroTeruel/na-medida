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
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                Color.gray.opacity(0.3)
            }
        }
        .frame(width: 70, height: 70)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 3))
    }
}

#Preview {
    RecipeIngredientImageView(urlString: "")
}
