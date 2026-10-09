//
//  EditRecipeView.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 06/10/26.
//
import SwiftUI
import SwiftData

struct EditRecipeView: View {
    @Bindable var recipe: Recipe
    @Environment(\.modelContext) private var modelContext
    @Environment(Router.self) private var router
    
    @State private var isShowingTagSheet = false
    
    @State private var isShowingCancelAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                TextField("Minha receita", text: $recipe.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button {
                    isShowingTagSheet = true
                } label: {

                    if let tag = recipe.tag {

                        Text(tag.rawValue)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(tag.foregroundColor)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .background(
                                tag.color.opacity(0.3)
                            )
                            .clipShape(Capsule())
                            .overlay {
                                Capsule()
                                    .strokeBorder(
                                        tag.foregroundColor.opacity(0.5),
                                        style: StrokeStyle(dash: [4])
                                    )
                            }

                    } else {

                        Label(
                            "Adicionar categoria",
                            systemImage: "plus"
                        )
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background {
                            Capsule()
                                .fill(.quaternary.opacity(0.5))
                        }
                        .overlay {
                            Capsule()
                                .strokeBorder(
                                    .secondary.opacity(0.4),
                                    style: StrokeStyle(dash: [4])
                                )
                        }
                    }
                }
                .buttonStyle(.plain)
                Text("Informações nutricionais")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                CarouselView(recipe: recipe)
                    .opacity(0.4)
                    .disabled(true)
                
                Button {
                    router.navigate(to: .scanner(recipe))
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    cancelChanges()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.primary)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    saveChanges()
                } label: {
                    Image(systemName: "checkmark")
                }
                .buttonStyle(.glassProminent)
                .tint(Color("buttonColor"))
            }
        }
        
        .sheet(isPresented: $isShowingTagSheet) {
            TagSheetView(
                recipe: recipe,
                cancelAction: { isShowingTagSheet = false },
                confirmAction: { isShowingTagSheet = false }
            )
            .presentationDetents([.medium])
            .presentationBackground(.background)
        }
        
        .alert("Descartar alterações?", isPresented: $isShowingCancelAlert) {
            Button("Descartar", role: .destructive) {
                modelContext.rollback()
                router.pop()
            }
            Button("Continuar Editando", role: .cancel) { }
        } message: {
            Text("Todas as alterações feitas nesta receita serão perdidas.")
        }
        
        .onAppear {
            SwipeController.shared.swipeAction = {
                if modelContext.hasChanges {
                    isShowingCancelAlert = true
                    return false
                }
                return true
            }
        }
        .onDisappear {
            SwipeController.shared.swipeAction = nil
        }
    }
    
    private func saveChanges() {
        do {
            try modelContext.save()
            router.pop()
        } catch {
            print("Erro ao salvar alterações da receita: \(error)")
        }
    }
    
    private func cancelChanges() {
        if modelContext.hasChanges {
            isShowingCancelAlert = true
        } else {
            router.pop()
        }
    }
    
    private func removeIngredient(_ recipeIngredient: RecipeIngredient) {
        if let index = recipe.ingredients.firstIndex(where: { $0.persistentModelID == recipeIngredient.persistentModelID }) {
            recipe.ingredients.remove(at: index)
            modelContext.delete(recipeIngredient)
        }
    }
}



#Preview("Editar Receita") {
    let container = try! ModelContainer(
        for:
            Recipe.self,
        RecipeIngredient.self,
        Ingredient.self,
        configurations: ModelConfiguration(
            isStoredInMemoryOnly: true
        )
    )
    
    let recipe = Recipe(
        name: "Macarrão à Bolonhesa",
        tag: .dinner
    )
    
    let ingredient1 = Ingredient(
        barcode: nil,
        name: "Carne Moída",
        brand: "Friboi",
        photoURL: nil,
        caloriesPer100g: 250,
        proteinsPer100g: 26,
        carbsPer100g: 0,
        fatsPer100g: 17
    )
    
    let ingredient2 = Ingredient(
        barcode: nil,
        name: "Molho de Tomate",
        brand: "Pomodoro",
        photoURL: nil,
        caloriesPer100g: 30,
        proteinsPer100g: 1.5,
        carbsPer100g: 5,
        fatsPer100g: 0.5
    )
    
    let recipeIngredient1 = RecipeIngredient(
        userQuantity: 300,
        unity: .g,
        ingredient: ingredient1,
        recipe: recipe
    )
    
    let recipeIngredient2 = RecipeIngredient(
        userQuantity: 500,
        unity: .ml,
        ingredient: ingredient2,
        recipe: recipe
    )
    
    recipe.ingredients = [
        recipeIngredient1,
        recipeIngredient2
    ]
    
    container.mainContext.insert(recipe)
    container.mainContext.insert(ingredient1)
    container.mainContext.insert(ingredient2)
    
    return NavigationStack {
        EditRecipeView(recipe: recipe)
    }
    .environment(Router())
    .modelContainer(container)
}
