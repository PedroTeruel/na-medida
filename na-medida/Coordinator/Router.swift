//
//  Router.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI
import Observation

enum AppRoute: Hashable {
    case recipesinfo(Recipe)
    case newrecipe
    case scanner
    case main(username: String)
    case ingredientinfo(ProductOpenFoodFactsDTO?)
}

@Observable
class Router {
    var selectedTab: AppTab = .tabrecipesview
    
    var recipesPath = [AppRoute]()
    var settingsPath = [AppRoute]()
    var searchPath = [AppRoute]()
    
    var draftTitle: String = ""
    var draftTag: RecipeTag = .breakfast
    var recipeSaveIngredient: [ProductOpenFoodFactsDTO] = []
    
    func clearDraft() {
        draftTitle = ""
        draftTag = .breakfast
        recipeSaveIngredient.removeAll()
    }
    
    func navigate(to route: AppRoute) {
        switch selectedTab {
        case .tabrecipesview:
            if case .recipesinfo = route {
                recipesPath = [route]
                return
            }
            
            guard recipesPath.last != route else { return }
            recipesPath.append(route)
            
        case .tabsettingsview:
            guard settingsPath.last != route else { return }
            settingsPath.append(route)
        case .tabsearchview:
            guard searchPath.last != route else { return }
            searchPath.append(route)
        }
    }
    
    func pop() {
        switch selectedTab {
        case .tabrecipesview:
            if !recipesPath.isEmpty { recipesPath.removeLast() }
        case .tabsettingsview:
            if !settingsPath.isEmpty { settingsPath.removeLast() }
        case .tabsearchview:
            if !searchPath.isEmpty { searchPath.removeLast() }
        }
    }
    
    func popToRoot() {
        switch selectedTab {
        case .tabrecipesview:
            recipesPath.removeAll()
        case .tabsettingsview:
            settingsPath.removeAll()
        case .tabsearchview:
            searchPath.removeAll()
        }
    }
    
    @ViewBuilder
    func build(route: AppRoute) -> some View {
        
        switch route {
        case .main(let username):
            RecipesTabView(username: username)
            
        case .recipesinfo(let recipe):
            RecipesInfoView(recipe: recipe)
            
        case .newrecipe:
            NewRecipeView { title, tag in
                self.draftTitle = title
                self.draftTag = tag
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
