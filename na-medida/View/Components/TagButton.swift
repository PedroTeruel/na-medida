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

    // AINDA PRECISA INVERTER MAS VAI DAR PROBLEMA DE COR PELA OPACIDADE
//    private var backgroundColor: Color {
//        colorScheme == .dark ? tag.foregroundColor : tag.color
//    }
//
//    private var textColor: Color {
//        colorScheme == .dark ? .black : tag.foregroundColor
//    }
    
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
    
    
//    private var backgroundColor: Color {
//        if isSelected {
//            return colorScheme == .dark ? tag.color : tag.foregroundColor
//        } else {
//            return colorScheme == .dark ? tag.foregroundColor : tag.color
//        }
//    }

//    private var textColor: Color {
//        if isSelected {
//            return colorScheme == .dark ? tag.foregroundColor : tag.color
//        } else {
//            return colorScheme == .dark ? tag.color : tag.foregroundColor
//        }
//    }

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
