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
    case newrecipe
    case scanner
    case ingredientinfo(ProductOpenFoodFactsDTO?)
}

@Observable
class Router {
    var selectedTab: AppTab = .tabrecipesview
    var path = [AppRoute]()
    var recipeSaveIngredient: [ProductOpenFoodFactsDTO] = []
    
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
        case .newrecipe:
            NewRecipeView { title, tag in
                print(title)
                print(tag)
            }
        case .scanner:
            BarcodeAPIView()
        case .ingredientinfo(let product):
            if let product {
                IngredientView(
                    ingredientTitle: product.productName ?? "Produto Desconhecido",
                    ingredientBrands: product.brands ?? "Marca não identificada",
                    ingredientImageURL: product.fotoProdutoURL
                )
            } else {
                IngredientView()
            }
        }
    }
}
