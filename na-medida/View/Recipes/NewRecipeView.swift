//
//  NewRecipeSheet.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 30/09/26.
//

import SwiftUI

struct NewRecipeView: View {
    @Environment(Router.self) private var router
    @Environment(RecipeDraft.self) private var draft
    
    var body: some View {
        @Bindable var draftBindable = draft
        
        VStack {
            VStack(spacing: 58) {
                VStack(spacing: 8) {
                    Text("Titulo")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    TextField("Minha receita", text: $draftBindable.title)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .frame(width: 180)
                }
                
                VStack(spacing: 8) {
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
                columns: [GridItem(.adaptive(minimum:110))]
            ) {
                ForEach(RecipeTag.allCases, id: \.self) { tag in
                    TagButton(title: tag.rawValue, isSelected: draft.tag == tag) {
                        draft.tag = tag
                        
                    }
                }
            }
            
            Spacer()
            
            Button {
                router.navigate(to: .scanner(nil))
            } label: {
                Text("Próximo passo")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
            .tint(.button)
            .disabled(draft.title.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding()
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Criar Receita")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        NewRecipeView()
            .environment(Router())
            .environment(RecipeDraft())
    }
}
