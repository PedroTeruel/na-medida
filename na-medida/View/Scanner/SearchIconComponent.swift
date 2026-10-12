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
            
            Text("Escaneie o código de barras ou pesquise o ingrediente pelo nome")
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
            
            Text("Para melhores resultados, digite o nome exato do produto e/ou da marca.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 300)
        .padding(.top, 16)
    }
}

#Preview {
    SearchIconComponent()
}
