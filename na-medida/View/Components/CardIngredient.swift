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
    var isAdded: Bool
    var onAdd: (() -> Void)?
    var onRemove: (() -> Void)?
    
    private var formattedProductName: String {
        let isTaco = brand?.uppercased().contains("TACO") ?? false
        if isTaco {
            return productName.trimmingCharacters(in: .whitespaces).uppercased()
        }
        
        let separators = CharacterSet(charactersIn: "-–—")
        let components = productName.components(separatedBy: separators)
        let baseName = components.first?.trimmingCharacters(in: .whitespaces) ?? productName
        return baseName.uppercased()
    }
    
    private var displayBrand: String? {
        guard let b = brand, !b.isEmpty else {
            return nil
        }
        if b.uppercased().contains("TACO") {
            return nil
        }
        return b
    }
    
    private var hasBrandOrQuantity: Bool {
        return (brand != nil && !brand!.isEmpty) || (quantity != nil && !quantity!.isEmpty)
    }
    
    init(
        productName: String = "Achocolatado",
        brand: String? = nil,
        quantity: String? = nil,
        imageURL: String? = nil,
        isAdded: Bool = false,
        onAdd: (() -> Void)? = nil,
        onRemove: (() -> Void)? = nil
    ) {
        self.productName = productName
        self.brand = brand
        self.quantity = quantity
        self.imageURL = imageURL
        self.isAdded = isAdded
        self.onAdd = onAdd
        self.onRemove = onRemove
    }
    
    var body: some View {
        HStack {
            
            AsyncProductImage(urlString: imageURL, size: 64, cornerRadius: 16)
            
            VStack (alignment: .leading) {
                Text(formattedProductName)
                    .foregroundStyle(.primary)
                    .font(.callout)
                    .fontWeight(.regular)
                    .lineLimit(2)
                //.minimumScaleFactor(0.8)
                
                if hasBrandOrQuantity {
                    HStack {
                        if let brandToShow = displayBrand {
                            Text(brandToShow)
                        }
                        
                        if displayBrand != nil, let quantity = quantity, !quantity.isEmpty {
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
                    Image(systemName: isAdded ? "checkmark" : "plus")
                        .fontWeight(.bold)
                        .contentTransition(.symbolEffect(.replace))
                }
                .buttonStyle(.borderedProminent)
                .tint(isAdded ? .green : .button)
                .clipShape(Circle())
                .disabled(isAdded)
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
