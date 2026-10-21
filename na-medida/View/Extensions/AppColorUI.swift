//
//  AppColorUI.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 21/10/26.
//

import SwiftUI

extension AppColor {
    var color: Color {
        switch self {
        case .blue: return .blue
        case .orange: return .orange
        case .purple: return .purple
        case .mint: return .mint
        case .indigo: return .indigo
        case .red: return .red
        case .yellow: return .yellow
        case .green: return .green
        case .cyan: return .cyan
        case .pink: return .pink
        case .brown: return .brown
        case .teal: return .teal
        case .gray: return .gray
        }
    }
}
