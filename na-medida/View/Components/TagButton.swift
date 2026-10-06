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
    
    var tag: RecipeTag

    var body: some View {
        
        HStack {
            Text(tag.rawValue)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
        .background(tag.color)
        .foregroundStyle(tag.foregroundColor)
        .cornerRadius(24)
    }
}

extension RecipeTag {
    var carouselImageBaseName: String {
        switch self {
        case .breakfast: return "Wave1"
        case .lunch: return "Wave3"
        case .dinner: return "Wave2"
        case .morningSnack: return "FundoCarouselRed"
        case .afternoonSnack: return "FundoCarouselPink"
        case .nightSnack: return "FundoCarouselBlue"
        case .dessert: return "Wave4"
        }
    }
}

#Preview {
    TagStatic(tag: .morningSnack)
}
