//
//  SettingsView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI

struct SettingsView: View {
    @Environment(Router.self) private var router
    
    var body: some View {
        @Bindable var routerBindable = router
        
        
        NavigationStack(path: $routerBindable.path) {
            VStack {
                Text("Settings")
            }
            .navigationTitle("Ajustes")
            .navigationDestination(for: AppRoute.self) { route in
                router.build(route: route)
            }
        }
        
    }
}

#Preview {
    SettingsView()
        .environment(Router())
}
