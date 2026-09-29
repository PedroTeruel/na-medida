//
//  ContentView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 28/09/26.
//

import SwiftUI

struct ContentView: View {
    @State private var router = Router()
    
    var body: some View {
        
        TabView(selection: $router.selectedTab) {
            
            
            Tab("Receitas", systemImage: "book.pages.fill", value: AppTab.tabrecipesview) {
                RecipesView()
            }
            
            Tab("Ajustes", systemImage: "gearshape.fill", value: AppTab.tabsettingsview) {
                SettingsView()
            }
            
            Tab("Pesquisar", systemImage: "magnifyingglass", value: AppTab.tabsearchview, role: .prominent) {
                SearchingTabView()
            }
        }
        .environment(router)
    }
}

#Preview {
    ContentView()
}
