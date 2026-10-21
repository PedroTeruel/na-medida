//
//  CardSheet.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 01/10/26.
//

import SwiftUI

struct CardSheet: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var productName: String
    var brand: String?
    var quantity: String?
    var imageURL: String?
    var isAdded: Bool
    var onAdd: (() -> Void)?
    var onRemove: (() -> Void)?
    
    private var hasBrandOrQuantity: Bool {
        let hasBrand = (brand != nil && !brand!.isEmpty)
        let hasQty = (quantity != nil && !quantity!.isEmpty)
        return hasBrand || hasQty
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
            
            VStack(alignment: .leading) {
                Text(productName.uppercased())
                    .foregroundStyle(.primary)
                    .font(.callout)
                    .fontWeight(.regular)
                    .lineLimit(2)
                
                if hasBrandOrQuantity {
                    HStack {
                        if let brand, !brand.isEmpty {
                            Text(brand)
                        }
                        
                        if let brand, !brand.isEmpty, let quantity, !quantity.isEmpty {
                            Text("•")
                        }
                        
                        if let quantity, !quantity.isEmpty {
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
                    Image(systemName: "trash.fill")
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
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(colorScheme == .dark ? Color(.secondarySystemBackground) : .white)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.black, lineWidth: 0.1)
        )
    }
}

#Preview {
    VStack {
        CardSheet(productName: "Cioccolato Fondente Deciso")
        
        CardSheet(
            productName: "Cioccolato Fondente Deciso",
            brand: "Lindt",
            quantity: "100g",
            onAdd: {}
        )
        
        CardSheet(
            productName: "Cioccolato Fondente Deciso",
            brand: "Lindt",
            quantity: "100g",
            onRemove: {}
        )
    }
}
