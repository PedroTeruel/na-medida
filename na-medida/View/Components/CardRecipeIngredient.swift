//
//  CardRecipeIngredient.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 01/10/26.
//

import SwiftUI

struct CardRecipeIngredient: View {
    var productName: String?
    var imageURL: String?
    var brands: String?
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                Text(productName ?? "produto sem nome")
                    .foregroundStyle(.primary)
                    .font(.title3)
                    .fontWeight(.bold)
                
                if let brands = brands, !brands.isEmpty {
                    Text(brands)
                        .foregroundStyle(.primary)
                        .font(.subheadline)
                }
            }
            Spacer ()
            if let imageURLString = imageURL, let url = URL(string: imageURLString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    default:
                        Color.gray
                    }
                }
                .frame(width: 48, height: 48)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 8)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.quinary, in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
        
    }
    
}
#Preview {
    CardRecipeIngredient(
        productName: "Achocolatado",
        imageURL: "Nescau",
        brands: "Nestlé"
    )
}
