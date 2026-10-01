//
//  na_medidaApp.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 28/09/26.
//
import SwiftData
import SwiftUI

@main
struct na_medidaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            Recipe.self,
            RecipeIngredient.self,
            Ingredient.self
        ])
    }
}


//import SwiftUI
//import SwiftData
//
//@main
//struct na_medidaApp: App {
//
//    @State private var router = Router()
//
//    var body: some Scene {
//        WindowGroup {
//            @Bindable var routerBindable = router
//
//            NavigationStack(path: $routerBindable.path) {
//
//                OnBoardView { username in
//                    print("Nome:", username)
//                }
//                .navigationDestination(for: AppRoute.self) { route in
//                    router.build(route: route)
//                }
//            }
//            .environment(router)
//        }
//        .modelContainer(for: [
//            Recipe.self,
//            RecipeIngredient.self,
//            Ingredient.self
//        ])
//    }
//}
