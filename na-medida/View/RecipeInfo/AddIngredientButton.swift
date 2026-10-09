//
//  AddIngredientButton.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 01/10/26.
//

import SwiftUI

struct AddIngredientButton:  View {
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                Text("Ingredientes")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text("Adicione ingredientes")
                    .foregroundStyle(.white)
                    .font(.subheadline)
            }
            Spacer ()
            Image("IconeAdicionar")
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .padding(.horizontal, 8)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.button, in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}

#Preview {
    AddIngredientButton()
}
