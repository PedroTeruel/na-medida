//
//  RecipeTag.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 20/10/26.
//

import SwiftUI

extension RecipeTag {
    var color: Color {
        switch self {
        case .breakfast: return Color.tagCardOrange
        case .lunch: return Color.tagCardGreen
        case .dinner: return Color.tagCardPurple
        case .morningSnack: return Color.tagCardRed
        case .afternoonSnack: return Color.tagCardPink
        case .nightSnack: return Color.tagCardBlue
        case .dessert: return Color.tagCardYellow
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .breakfast: return Color.tagTextOrange
        case .lunch: return Color.tagTextGreen
        case .dinner: return Color.tagTextPurple
        case .morningSnack: return Color.tagTextRed
        case .afternoonSnack: return Color.tagTextPink
        case .nightSnack: return Color.tagTextBlue
        case .dessert: return Color.tagTextYellow
        }
    }
    
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
