//
//  CardIngredient.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 01/10/26.
//

import SwiftUI

struct CardIngredient: View {
    var productName: String
    var imageURL: String?
    var showActions: Bool
    
    @State private var selectionQuantity = "Defina a quantidade"
    let measures = ["Unidade", "Gramas", "Kilogramas", "Litros"]
    
    init(
        productName: String = "Achocolatado",
        imageURL: String? = nil,
        showActions: Bool = true
    ) {
        self.productName = productName
        self.imageURL = imageURL
        self.showActions = showActions
    }
    
    var body: some View {
        HStack {
            
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
                .frame(width: 64, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .padding(16)
                    .frame(width: 64, height: 64)
                    .background(Color.gray.opacity(0.2))
                    .foregroundStyle(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            VStack (alignment: .leading) {
                Text(productName)
                    .foregroundStyle(.primary)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                
                if showActions {
                    Menu {
                        ForEach(measures, id: \.self) { measure in
                            Button(measure) {
                                selectionQuantity = measure
                            }
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text(selectionQuantity)
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                            
                            Image(systemName: "chevron.up.chevron.down")
                                .font(.caption2)
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
            
            Button {
                print("Adicionar ingrediente na RecipeInfoView")
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(.borderedProminent)
            .clipShape(Circle())
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 74)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.primary, lineWidth: 0.3))
    }
}

#Preview {
    VStack {
        CardIngredient(productName: "Achocolatado Nescau", showActions: true)
        CardIngredient(productName: "Leite Integral", showActions: false)
    }
    .padding()
}
