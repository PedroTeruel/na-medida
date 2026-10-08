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
    var isEditable: Bool
    @Binding var userQuantity: Double
    @Binding var unity: QntUnity
    var onRemove: (() -> Void)?
    
    init(
        productName: String? = nil,
        imageURL: String? = nil,
        brands: String? = nil,
        isEditable: Bool = false,
        userQuantity: Binding<Double> = .constant(0.0),
        unity: Binding<QntUnity> = .constant(.g),
        onRemove: (() -> Void)? = nil
    ) {
        self.productName = productName
        self.imageURL = imageURL
        self.brands = brands
        self.isEditable = isEditable
        self._userQuantity = userQuantity
        self._unity = unity
        self.onRemove = onRemove
    }
    
    var body: some View {
        HStack{
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
                .padding(.horizontal, 4)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 4)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text((productName ?? "produto sem nome").uppercased())
                    .foregroundStyle(.primary)
                    .font(.title3)
                    .fontWeight(.bold)
                
                if let brands = brands, !brands.isEmpty {
                    Text(brands)
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
                
                if isEditable {
                    HStack(spacing: 6) {
                        TextField("Qtd", value: $userQuantity, format: .number)
                            .keyboardType(.decimalPad)
                            .fixedSize()
                        
                        Picker("", selection: $unity) {
                            ForEach([QntUnity.un, .g, .kg, .ml, .l], id: \.self) { unit in
                                Text(unit.formatted).tag(unit)
                            }
                        }
                        .pickerStyle(.menu)
                        .labelsHidden()
                    }
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                } else {
                    Text("\(userQuantity.formatted()) \(unity.formatted)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            if isEditable, let onRemove = onRemove {
                Button(action: onRemove) {
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                        .padding(8)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.systemBackground))
                .shadow(
                    color: .black.opacity(0.15),
                    radius: 6,
                    x: 0,
                    y: 4
                )
        }
        .padding(.horizontal)
    }
}

#Preview {
    VStack(spacing: 20) {
        CardRecipeIngredient(
            productName: "Achocolatado",
            imageURL: nil,
            brands: "Nestlé",
            isEditable: true,
            userQuantity: .constant(100.0),
            unity: .constant(.g),
            onRemove: { print("Apagar") }
        )
        
        CardRecipeIngredient(
            productName: "Leite Integral",
            imageURL: nil,
            brands: "Elegê",
            isEditable: false,
            userQuantity: .constant(200.0),
            unity: .constant(.ml)
        )
    }
}
