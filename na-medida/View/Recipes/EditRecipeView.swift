//
//  EditRecipeView.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 06/10/26.

import SwiftUI
import SwiftData

struct EditRecipeView: View {
    @Bindable var recipe: Recipe
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(Router.self) private var router
    
    @State private var isShowingTagSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                TextField("Minha receita", text: $recipe.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .autocorrectionDisabled()
                
                Button {
                    isShowingTagSheet = true
                } label: {
                    Text(recipe.tag.rawValue)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(recipe.tag.foregroundColor)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(recipe.tag.color.opacity(0.3))
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .strokeBorder(recipe.tag.foregroundColor.opacity(0.5), style: StrokeStyle(dash: [4]))
                        )
                }
                
                    Text("Informações nutricionais")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    CarouselView(recipe: recipe)
                    .opacity(0.4)
                    .disabled(true)
                
                
                Button {
                    router.navigate(to: .scanner(nil))
                } label: {
                    AddIngredientButton()
                }
                
                    if recipe.ingredients.isEmpty {
                        Text("Nenhum ingrediente adicionado.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.vertical, 12)
                    } else {
                        ForEach(recipe.ingredients) { item in
                            if let index = recipe.ingredients.firstIndex(where: { $0.id == item.id }) {
                                CardRecipeIngredient(
                                    productName: item.ingredient?.name,
                                    imageURL: item.ingredient?.photoURL,
                                    brands: item.ingredient?.brand,
                                    isEditable: true,
                                    userQuantity: $recipe.ingredients[index].userQuantity,
                                    unity: $recipe.ingredients[index].unity,
                                    onRemove: {
                                        removeIngredient(item)
                                    }
                                )
                            }
                        }
                    }
            }
            .padding(.top, 16)
        }
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    saveChanges()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.body.weight(.bold))
                        .foregroundStyle(.blue)
                }
            }
        }
        
        .sheet(isPresented: $isShowingTagSheet) {
            TagSheetView(
                recipe: recipe,
                cancelAction: { isShowingTagSheet = false },
                confirmAction: { isShowingTagSheet = false }
            )
            .presentationDetents([.medium])
        }
    }
    
    private func saveChanges() {
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Erro ao salvar alterações da receita: \(error)")
        }
    }
    
    private func removeIngredient(_ recipeIngredient: RecipeIngredient) {
        if let index = recipe.ingredients.firstIndex(where: { $0.persistentModelID == recipeIngredient.persistentModelID }) {
            recipe.ingredients.remove(at: index)
            modelContext.delete(recipeIngredient)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Recipe.self, RecipeIngredient.self, Ingredient.self, configurations: config)
    
    let sampleIngredient = Ingredient(
        barcode: "123456",
        name: "Achocolatado em pó, NESCAU Nestlé - 350g",
        brand: "Nestlé",
        photoURL: nil,
        caloriesPer100g: 370.0,
        proteinsPer100g: 4.0,
        carbsPer100g: 80.0,
        fatsPer100g: 2.0
    )
    
    let sampleRecipeIngredient = RecipeIngredient(
        userQuantity: 100.0,
        unity: .g,
        ingredient: sampleIngredient
    )
    
    let sampleRecipe = Recipe(
        name: "Minha receita",
        tag: .dinner
    )
    
    sampleRecipe.ingredients.append(sampleRecipeIngredient)
    container.mainContext.insert(sampleRecipe)
    
    return EditRecipeView(recipe: sampleRecipe)
        .modelContainer(container)
        .environment(Router())
}

