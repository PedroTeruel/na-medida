//
//  CardIngredient.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 01/10/26.
//

import SwiftUI

struct CardIngredient: View {
    var productName: String
    var brand: String?
    var quantity: String?
    var imageURL: String?
    var onAdd: (() -> Void)?
    var onRemove: (() -> Void)?
    
    private var formattedProductName: String {
        let separators = CharacterSet(charactersIn: "-–—")
        let components = productName.components(separatedBy: separators)
        return components.first?.trimmingCharacters(in: .whitespaces) ?? productName
    }
    
    private var hasBrandOrQuantity: Bool {
        return (brand != nil && !brand!.isEmpty) || (quantity != nil && !quantity!.isEmpty)
    }
    
    init(
        productName: String = "Achocolatado",
        brand: String? = nil,
        quantity: String? = nil,
        imageURL: String? = nil,
        onAdd: (() -> Void)? = nil,
        onRemove: (() -> Void)? = nil
    ) {
        self.productName = productName
        self.brand = brand
        self.quantity = quantity
        self.imageURL = imageURL
        self.onAdd = onAdd
        self.onRemove = onRemove
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
                Text(formattedProductName)
                    .foregroundStyle(.primary)
                    .font(.callout)
                    .fontWeight(.regular)
                    .lineLimit(1)
                //.minimumScaleFactor(0.8)
                
                if hasBrandOrQuantity {
                    HStack {
                        if let brand = brand, !brand.isEmpty {
                            Text(brand)
                        }
                        
                        if let brand = brand, !brand.isEmpty, let quantity = quantity, !quantity.isEmpty {
                            Text("•")
                        }
                        
                        if let quantity = quantity, !quantity.isEmpty {
                            Text(quantity)
                        }
                    }
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                    .lineLimit(1)
                }
            }
            .padding(8)
            
            Spacer()
            
            if let onRemove = onRemove {
                Button {
                    onRemove()
                } label: {
                    Image(systemName: "trash")
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .clipShape(Circle())
                
            } else if let onAdd = onAdd {
                Button {
                    onAdd()
                } label: {
                    Image(systemName: "plus")
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                .tint(.button)
                .clipShape(Circle())
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity, minHeight: 60)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.primary, lineWidth: 0.1))
    }
}

#Preview {
    VStack {
        CardIngredient(productName: "Cioccolato Fondente Deciso – Lindt – 100g")
        
        CardIngredient(
            productName: "Cioccolato Fondente Deciso – Lindt – 100g",
            brand: "Lindt",
            quantity: "100g",
            onAdd: {})
        
        CardIngredient(
            productName: "Cioccolato Fondente Deciso – Lindt – 100g",
            brand: "Lindt",
            quantity: "100g",
            onRemove: {})
    }
}
