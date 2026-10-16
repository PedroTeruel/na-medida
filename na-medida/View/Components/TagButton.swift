//
//  TagButton.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 30/09/26.
//

import SwiftUI

struct TagButton: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let tag: RecipeTag
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    private var backgroundColor: Color {
        if colorScheme == .dark {
            if isSelected{
                return tag.foregroundColor
            } else{
                return tag.color
            }
        } else {
            if isSelected{
                return tag.color
            }else{
                return tag.color
            }
        }
    }
    
    private var textColor: Color {
        if colorScheme == .dark {
            if isSelected{
                return tag.color
            } else{
                return tag.foregroundColor
            }
        } else {
            if isSelected{
                return tag.foregroundColor
            }else{
                return tag.foregroundColor
            }
        }
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fixedSize(horizontal: false, vertical: true)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background {
                    Capsule()
                        .fill(backgroundColor.opacity(isSelected ? 1 : 0.3))
                }
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundStyle(textColor)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
        }
        .buttonStyle(.plain)
    }
}
