//
//  SettingsView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(Router.self) private var router
    @Environment(\.modelContext) private var mc
    @State private var showEditSheet = false
    
    let user: User
    
    var body: some View {
        @Bindable var routerBindable = router
        
        NavigationStack(path: $routerBindable.settingsPath) {
            
            VStack {
                Text("""
                     Olá,
                     \(user.username)!
                     """)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.semibold)
                Button("Alterar nome") {
                    showEditSheet = true
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 32)
            
            VStack(alignment: .leading) {
                Text("Sobre nutrientes")
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 8)
                
                Button {
                    router.navigate(to: .aboutNutrients)
                    } label: {
                        AboutNutrientsCard(
                            cardTitle: "Definição dos nutrientes",
                            cardBody: "Entenda melhor sobre os ingredientes das suas receitas",
                            cardImg: "book" )
                    }
                    .buttonStyle(.plain)
                
                Button {
                    router.navigate(to: .aboutMeasures)
                } label: {
                    AboutNutrientsCard(
                        cardTitle: "Tabela de medidas",
                        cardBody: "Veja como descobrir a medida das suas receitas",
                        cardImg: "scalemass" )
                }
                .buttonStyle(.plain)
            }
            .padding()
            
            VStack(alignment: .leading) {
                Text("Informações sobre o Na Medida")
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 8)
                
                HStack {
                    Button {
                        router.navigate(to: .aboutUs)
                    } label: {
                        AboutAppCard(iconCard: "info.circle", aboutTitle: "Sobre nós")
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        router.navigate(to: .termsOfUse)
                    } label: {
                        AboutAppCard(iconCard: "clipboard", aboutTitle: "Termos de uso")
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
            .navigationDestination(for: AppRoute.self) { route in
                router.build(route: route)
            }
            
            Spacer()
        }
        .sheet(isPresented: $showEditSheet) {
            EditNameSheet { newUsername in
                
                let repository = UserRepository(mc: mc)
                
                repository.editUsername(
                    user: user,
                    newUsername: newUsername
                )
            }
        }
    }
}

#Preview {
    SettingsView(user: User(username: "William"))
        .environment(Router())
        .modelContainer(
            for: User.self,
            inMemory: true
        )
}
