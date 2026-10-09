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
    
    @FocusState private var isTitleFocused: Bool
    
    @State private var showDiscardAlert = false
    
    private var ifModifications: Bool {
        !draft.title.trimmingCharacters(in: .whitespaces).isEmpty || !draft.ingredients.isEmpty || draft.tag != .breakfast
    }
    
    var body: some View {
        @Bindable var draftBindable = draft
        
        VStack {
            VStack(spacing: 58) {
                VStack(spacing: 8) {
                    Text("Título")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    TextField("Minha receita", text: $draftBindable.title)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .autocorrectionDisabled()
                        .focused($isTitleFocused)
                }
                
                VStack(spacing: 8) {
                    Text("Vamos Organizar?")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Selecione uma categoria para criar sua receita")
                        .font(.body)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
            
            FlowLayout(spacing: 12, rowSpacing: 12) {
                ForEach(RecipeTag.allCases, id: \.self) { tag in
                    TagButton(tag: tag, title: tag.rawValue, isSelected: draft.tag == tag) {
                        //draft.tag = tag
                        
                        if draft.tag == tag {
                            draft.tag = nil
                        } else {
                            draft.tag = tag
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            
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
        .contentShape(Rectangle())
        .onTapGesture {
            isTitleFocused = false
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Criar Receita")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: . topBarLeading) {
                Button {
                    if ifModifications {
                        showDiscardAlert = true
                    } else {
                        draft.clear()
                        router.pop()
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .fontWeight(.medium)
                    }
                }
            }
        }
        .alert("Descartar Receita?", isPresented: $showDiscardAlert) {
            Button("Cancelar", role: .cancel) { }
            
            Button("Descartar", role: .destructive) {
                draft.clear()
                router.pop()
            }
        } message: {
            Text("Se você voltar, todas as informações adicionadas serão perdidas.")
        }
        .onAppear {
            SwipeController.shared.swipeAction = {
                if ifModifications {
                    showDiscardAlert = true
                    return false
                }
                return true
            }
        }
        .onDisappear {
            SwipeController.shared.swipeAction = nil
        }
    }
}

#Preview {
    NavigationStack {
        NewRecipeView()
            .environment(Router())
            .environment(RecipeDraft())
    }
}
