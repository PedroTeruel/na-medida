//
//  EditRecipeView.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 06/10/26.
//

//import SwiftUI
//import SwiftData
//
//struct EditRecipeView: View {
//    @Environment(Router.self) private var router
//    @Environment(\.modelContext) private var mc
//    
//    @Bindable var recipe: Recipe
//    
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20) {
//                
//                // 1. Campo para editar o nome da receita
//                TextField("Nome da receita", text: $recipe.name)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.center)
//                    .textFieldStyle(.plain)
//                    .padding(.top)
//                
////                 //2. Campo para editar a Tag / Categoria da receita
////                TextField("Categoria", text: $recipe.tag)
////                    .font(.subheadline)
////                    .multilineTextAlignment(.center)
////                    .padding(.horizontal, 16)
////                    .padding(.vertical, 8)
////                    .background(Color.secondary.opacity(0.15))
////                    .clipShape(Capsule())
//                
//                // 3. Botão para Adicionar Novos Ingredientes
//                Button {
//                    router.navigate(to: .scanner(recipe))
//                } label: {
//                    AddIngredientButton()
//                }
//                .buttonStyle(.plain)
//                .padding(.top, 10)
//                
//                // 4. Lista dos Ingredientes com Quantidades Editáveis
//                VStack(spacing: 12) {
//                    if recipe.ingredients.isEmpty {
//                        Text("Nenhum ingrediente adicionado")
//                            .foregroundStyle(.secondary)
//                            .padding(.top, 20)
//                    } else {
//                        ForEach(recipe.ingredients) { recipeIng in
//                            // Wrapper de Binding para vincular o objeto do SwiftData
//                            IngredientRowView(recipeIng: recipeIng) {
//                                deleteIngredient(recipeIng)
//                            }
//                        }
//                    }
//                }
//            }
//            .padding(.horizontal)
//        }
//        .navigationBarBackButtonHidden(true)
//        .toolbar(.hidden, for: .tabBar)
//        .navigationTitle("Editar Receita")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .topBarLeading) {
//                Button("Cancelar") {
//                    router.pop()
//                }
//            }
//            ToolbarItem(placement: .topBarTrailing) {
//                Button("Salvar") {
//                    try? mc.save()
//                    router.pop()
//                }
//                .fontWeight(.bold)
//            }
//        }
//    }
//    
//    private func deleteIngredient(_ ingredient: RecipeIngredient) {
//        if let index = recipe.ingredients.firstIndex(where: { $0.id == ingredient.id }) {
//            recipe.ingredients.remove(at: index)
//            mc.delete(ingredient)
//        }
//    }
//}
//
//// Subview auxiliar para expor os Bindings de cada RecipeIngredient no ForEach
//private struct IngredientRowView: View {
//    @Bindable var recipeIng: RecipeIngredient
//    var onDelete: () -> Void
//    
//    var body: some View {
//        CardIngredient(
//            productName: recipeIng.ingredient?.name ?? "",
//            imageURL: recipeIng.ingredient?.photoURL,
//            isEditable: true,
//            userQuantity: $recipeIng.userQuantity,
//            unity: $recipeIng.unity,
//            onRemove: onDelete
//        )
//    }
//}





