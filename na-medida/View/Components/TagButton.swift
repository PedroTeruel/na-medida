//
//  TagButton.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 30/09/26.
//

import SwiftUI

struct TagButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .font(.subheadline)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.button : Color.gray.opacity(0.2))
                .foregroundStyle(isSelected ? .white : .primary)
                .cornerRadius(10)
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
    TagButton(title: "Example", isSelected: false) {
    }
}

#Preview {
    TagStatic(title: "Categoria")
}
