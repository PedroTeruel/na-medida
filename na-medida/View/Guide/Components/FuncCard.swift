//
//  FuncCard.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 08/10/26.
//

import SwiftUI

struct FuncCard: View {
    var funcIcon: String
    var funcText: String
    var body: some View {
        HStack(spacing: 22){
            Image(funcIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            Text(funcText)
            Spacer()
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.quinary)
        )
    }
}

#Preview {
    FuncCard(funcIcon: "RayIcon", funcText: "Fonte de energia")
}
