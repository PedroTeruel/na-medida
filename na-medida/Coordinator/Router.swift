//
//  Router.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI
import Foundation
import Observation

enum AppRoute: Hashable {
    case recipe
    case scanner
}

@Observable
class Router {
    var selectedTab: AppTab = .homeview
    var path = [AppRoute]()
    
    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    @ViewBuilder
    func build(route: AppRoute) -> some View {
        switch route {
        case .recipe:
            RecipeView()
        case .scanner:
            ScannerView()
        }
    }
}
