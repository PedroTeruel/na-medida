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
            Spacer()
            Text("Titulo")
                .font(.title3)
                .fontWeight(.semibold)
            TextField("Minha receita", text: $title)
                .textFieldStyle(.roundedBorder)
            Spacer()
            Text("Vamos Organizar?")
                .font(.title3)
                .fontWeight(.semibold)
            Text("Selecione uma categoria para guardar sua receita")
                .font(.body)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            HStack {
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
                        isSelected: tag == .snack
                    ) {
                        tag = .snack
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
    NewRecipeSheet { title, tag in
        print("Título: \(title)")
        print("Tag: \(tag)")
    }
}
