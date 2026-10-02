//
//  AboutView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 02/10/26.
//
import SwiftData
import SwiftUI

struct GuideView: View {
    @Environment(\.modelContext) private var mc
    
    let user: User
    @State private var showEditSheet = false
    
    var body: some View {
        VStack(spacing: 40){
            VStack{
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
            VStack(spacing: 18){
                Text("Sobre nutrientes")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                AboutNutrientsCard(
                    cardTitle: "Definição dos nutrientes",
                    cardBody: "Entenda melhor sobre os ingredientes",
                    cardImg: "book"
                )
                AboutNutrientsCard(
                    cardTitle: "Tabela de medidas",
                    cardBody: "Veja como descobrir a medida das suas receitas",
                    cardImg: "scalemass"
                )
            }
            .padding(.horizontal, 16)
            VStack(spacing: 18){
                Text("Sobre nutrientes")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(){
                    HStack{
                        AboutAppCard(
                            iconCard: "info.circle",
                            aboutTitle: "Sobre o app"
                        )
                        Spacer()
                        AboutAppCard(
                            iconCard: "clipboard",
                            aboutTitle: "Termos de uso"
                        )
                    }
                }
            }
            .padding(.horizontal, 16)
            Spacer()
        }
        .padding(.top, 20)
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
    GuideView(
        user: User(username: "William")
    )
    .modelContainer(
        for: User.self,
        inMemory: true
    )
}
