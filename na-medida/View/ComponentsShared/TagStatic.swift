//
//  TagStatic.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 16/10/26.
//

import SwiftUI

struct TagStatic: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var tag: RecipeTag?
    
    var body: some View {
        
        if let tag {
            Text(tag.rawValue)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    colorScheme == .dark
                    ? tag.foregroundColor
                    : tag.color
                )
                .foregroundStyle(
                    colorScheme == .dark
                    ? tag.color
                    : tag.foregroundColor
                )
                .clipShape(Capsule())
            
        } else {
            Text("Sem categoria")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview{
    TagStatic(tag: .morningSnack)
}
