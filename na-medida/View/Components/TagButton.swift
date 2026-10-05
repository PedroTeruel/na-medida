//
//  TagButton.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 30/09/26.
//

import SwiftUI

struct TagButton: View {
    let tag: RecipeTag
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .fixedSize(horizontal: false, vertical: true)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    (isSelected ? tag.color.opacity(1) : tag.color.opacity(0.3))
                        .clipShape(Capsule())
                )
                .foregroundStyle(tag.foregroundColor)
                .cornerRadius(24)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
        }
        .buttonStyle(.plain)
    }
}

struct TagStatic: View {
    var title: String
    var body: some View {
        
        HStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
        .background(Color(.systemGray4))
        .cornerRadius(24)
    }
}

#Preview {
    TagStatic(title: "Lanche da manhã")
}
