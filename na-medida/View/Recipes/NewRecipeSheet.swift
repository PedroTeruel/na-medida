//
//  NewRecipeSheet.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 30/09/26.
//

import SwiftUI

struct NewRecipeSheet: View {
    
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
        }
        .padding()
        .navigationTitle("Criar Receita")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button {
                    guard let tag else { return }
                    onContinue(title, tag)
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}


#Preview {
    NavigationStack{
        NewRecipeSheet { title, tag in
            print("Título: \(title)")
            print("Tag: \(tag)")
        }
    }
}
