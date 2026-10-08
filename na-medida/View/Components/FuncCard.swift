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
            Image(systemName: funcIcon)
                .frame(width: 22)
                .foregroundStyle(Color.orange)
            Text(funcText)
            Spacer()
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.quinary.opacity(0.5))
        )
    }
    
}

#Preview {
    FuncCard(funcIcon: "bolt.fill", funcText: "Fonte de energia")
}
