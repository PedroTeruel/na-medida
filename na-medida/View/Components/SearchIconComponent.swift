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
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 200)
        .padding(.top, 16)
    }
}

#Preview {
    SearchIconComponent()
}
