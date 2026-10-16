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

extension RecipeTag{
    var carouselImageBaseName: String{
        switch self{
        case .breakfast: return "Wave1"
        case .lunch: return "Wave3"
        case .dinner: return "Wave2"
        case .morningSnack: return "Wave6"
        case .afternoonSnack: return "Wave5"
        case .nightSnack: return "Wave7"
        case .dessert: return "Wave4"
        }
    }
}

#Preview{
    TagStatic(tag: .morningSnack)
}
