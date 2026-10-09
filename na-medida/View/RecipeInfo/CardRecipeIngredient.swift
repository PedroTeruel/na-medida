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
    //var brands: String?
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
        //self.brands = brands
        self.isEditable = isEditable
        self._userQuantity = userQuantity
        self._unity = unity
        self.onRemove = onRemove
    }
    
    var body: some View {
        HStack (spacing: 16) {
            
            AsyncProductImage(
                urlString: imageURL,
                size: 62,
                cornerRadius: 16
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text((productName ?? "produto sem nome").uppercased())
                    .foregroundStyle(.primary)
                    .font(.callout)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                
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
            Spacer()
            
            if isEditable, let onRemove = onRemove {
                Button {
                    onRemove()
                } label: {
                    Image(systemName: "trash.fill")
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .clipShape(Circle())
                
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.systemBackground))
                .shadow(
                    color: .primary.opacity(0.15),
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
            productName: "Leite Integral Integral Integral Integral",
            imageURL: nil,
            brands: "Elegê",
            isEditable: false,
            userQuantity: .constant(200.0),
            unity: .constant(.ml)
        )
    }
}
