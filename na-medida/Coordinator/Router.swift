//
//  Router.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI
import Observation

enum AppRoute: Hashable {
    case recipesinfo
    case scanner
    case ingredientinfo
}

@Observable
class Router {
    var selectedTab: AppTab = .tabrecipesview
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
        case .recipesinfo:
            RecipesInfoView()
        case .scanner:
            BarcodeAPIView()
        case .ingredientinfo:
            IngredientView()
        }
    }
}
