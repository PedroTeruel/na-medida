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
            Text("Adicionar Ingredientes")
                .foregroundStyle(.white)
                .font(.title3)
                .fontWeight(.semibold)
            
            Spacer ()
            
            Image("IconeAdicionar")
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
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
