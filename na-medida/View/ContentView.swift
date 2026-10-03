//
//  ContentView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 28/09/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var router = Router()
    @Environment(\.modelContext) private var mc
    @Query private var users: [User]
    
    var body: some View {
        
        if let currentUser = users.first {
            TabView(selection: $router.selectedTab) {
                
                Tab("Receitas", systemImage: "book.pages.fill", value: AppTab.tabrecipesview) {
                    RecipesTabView(username: currentUser.username)
                }
                
                Tab("Ajustes", systemImage: "gearshape.fill", value: AppTab.tabsettingsview) {
                    SettingsView()
                }
                
                Tab("Pesquisar", systemImage: "magnifyingglass", value: AppTab.tabsearchview, role: .prominent) {
                    SearchingTabView()
                }
            }
            
            .environment(router)
        } else {
            OnBoardView { newUsername in
                let repository = UserRepository(mc: mc)
                repository.createUser(username: newUsername)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [User.self, Recipe.self, RecipeIngredient.self, Ingredient.self], inMemory: true)
}
