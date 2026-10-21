//
//  TagSheetView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 29/09/26.
//

import SwiftUI
import SwiftData

struct TagSheetView: View {
    
    let recipe: Recipe
    
    @State private var selectedTag: RecipeTag?
    
    var cancelAction: () -> Void
    var confirmAction: () -> Void
    
    init(
        recipe: Recipe,
        cancelAction: @escaping () -> Void,
        confirmAction: @escaping () -> Void
    ) {
        self.recipe = recipe
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
        
        _selectedTag = State(initialValue: recipe.tag)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                VStack(spacing: 8) {
                    Text("Vamos Organizar?")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 24)
                    
                    Text("Selecione uma categoria para criar sua receita")
                        .font(.body)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                }
                .padding()
                
                
                FlowLayout(spacing: 12, rowSpacing: 12) {
                    ForEach(RecipeTag.allCases, id: \.self) { tag in
                        
                        TagButton(
                            tag: tag,
                            title: tag.rawValue,
                            isSelected: selectedTag == tag
                        ) {
                            selectedTag = tag
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 26)
                
                Spacer()
            }
            .padding(.top, 24)
            .navigationTitle("Editar categoria")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: cancelAction) {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        saveTag()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.glassProminent)
                    .tint(.button)
                }
            }
        }
    }
    
    private func saveTag() {
        recipe.tag = selectedTag
        confirmAction()
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    
    let container = try! ModelContainer(
        for: Recipe.self, RecipeIngredient.self, Ingredient.self,
        configurations: configuration
    )
    
    let recipe = Recipe(
        name: "Bolo de chocolate",
        tag: .breakfast
    )
    
    container.mainContext.insert(recipe)
    
    return TagSheetView(
        recipe: recipe,
        cancelAction: {},
        confirmAction: {}
    )
    .modelContainer(container)
}
