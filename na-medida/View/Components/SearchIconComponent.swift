//
//  SearchIconComponent.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 03/10/26.
//

import SwiftUI

struct SearchIconComponent: View {
    var body: some View {
        
        VStack (spacing: 16) {
            Image("IconeSearch")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
            Text("Escaneie ou busque para adicionar um ingrediente")
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
            
            Text("Para melhores resultados, digite o nome exato do produto/marca.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                
            
            
        }
        .frame(width: 220)
        .padding(.top, 16)
    }
}

#Preview {
    SearchIconComponent()
}
