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
            HomeView()
                .tabItem {
                    Label("Inicial" , systemImage: "house")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .environment(router)
    }
}

#Preview {
    ContentView()
}
