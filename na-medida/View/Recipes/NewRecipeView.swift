//
//  NewRecipeSheet.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 30/09/26.
//

import SwiftUI

struct NewRecipeView: View {
    
    @Environment(Router.self) private var router
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var tag: RecipeTag?
    
    let onContinue: (String, RecipeTag) -> Void
    
    var body: some View {
        VStack{
            VStack(spacing: 58){
                VStack(spacing: 8){
                    Text("Titulo")
                        .font(.title3)
                        .fontWeight(.semibold)
                    TextField("Minha receita", text: $title)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .frame(width: 180)
                }
                VStack(spacing: 8){
                    Text("Vamos Organizar?")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("Selecione uma categoria para guardar sua receita")
                        .font(.body)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                }
            }
            
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum:110))
                ]
            ) {
                TagButton(
                    title: "Café da manhã",
                    isSelected: tag == .breakfast
                ) {
                    tag = .breakfast
                }
                
                TagButton(
                    title: "Almoço",
                    isSelected: tag == .lunch
                ) {
                    tag = .lunch
                }
                
                TagButton(
                    title: "Jantar",
                    isSelected: tag == .dinner
                ) {
                    tag = .dinner
                }
                
                TagButton(
                    title: "Lanche",
                    isSelected: tag == .morningSnack
                ) {
                    tag = .morningSnack
                }
            }
            Spacer()
            
            Button {
                guard let tag else {
                    return
                }
                onContinue(title, tag)
                router.navigate(to: .scanner(nil))
            } label: {
                Text("Proximo passo")
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                
            }
            .buttonStyle(.bordered)
            .tint(.button)
            .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty || tag == nil)
        }
        .padding()
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Criar Receita")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    NavigationStack{
        NewRecipeView { title, tag in
            print("Título: \(title)")
            print("Tag: \(tag)")
        }
        .environment(Router())
    }
}
