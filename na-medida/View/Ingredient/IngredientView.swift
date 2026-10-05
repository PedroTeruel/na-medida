//
//  IngredientView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 30/09/26.
//
import SwiftUI

struct IngredientView: View {
        @Environment(Router.self) private var router
    
        @State private var segmentedControl = 0
        var ingredientTitle: String
        var ingredientBrands: String
        var ingredientImageURL: String?
    
        var items: [NutritionalFactsItem]
        var servingsPerContainer: String?
        var servingSizeText: String?
        var ingredientsText: String
        var allergensText: String?
    
        init(
            ingredientTitle: String = "Titulo do Ingrediente",
            ingredientBrands: String = "Marca",
            ingredientImageURL: String? = nil,
            items: [NutritionalFactsItem] = [],
            servingsPerContainer: String? = nil,
            servingSizeText: String? = nil,
            ingredientsText: String = "",
            allergensText: String? = nil
        ) {
            self.ingredientTitle = ingredientTitle
            self.ingredientBrands = ingredientBrands
            self.ingredientImageURL = ingredientImageURL
            self.items = items
            self.servingsPerContainer = servingsPerContainer
            self.servingSizeText = servingSizeText
            self.ingredientsText = ingredientsText
            self.allergensText = allergensText
    
            //essa config altera os outros segmented control do app
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.button
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBackground], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
        }
    
        init(productDTO: ProductOpenFoodFactsDTO) {
            self.init(
                ingredientTitle: productDTO.productName ?? "Título Indisponível",
                ingredientBrands: productDTO.brands ?? "Marca não informada",
                ingredientImageURL: productDTO.fotoProdutoURL,
                items: productDTO.nutritionalItems,
                servingsPerContainer: nil,
                servingSizeText: productDTO.servingSize,
                ingredientsText: productDTO.composicaoProduto ?? "",
                allergensText: productDTO.allergens
            )
        }
    
            init(ingredient: Ingredient) {
                self.init(
                    ingredientTitle: ingredient.name,
                    ingredientBrands: ingredient.brand ?? "Marca não identificada",
                    ingredientImageURL: ingredient.photoURL,
                    items: ingredient.nutritionalItems,
                    servingsPerContainer: nil,
                    servingSizeText: "100g",
                    ingredientsText: ingredient.ingredientsText ?? "Informação de composição",
                    allergensText: ingredient.allergensText
                )
            }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - Card com Imagem do Produto
                productImageCard
                
                // MARK: - Título e Marca
                VStack(spacing: 6) {
                    Text(ingredientTitle)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text(ingredientBrands)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                // MARK: - Seletor Segmentado
                Picker("Informações", selection: $segmentedControl) {
                    Text("Informação nutricional").tag(0)
                    Text("Composição").tag(1)
                }
                .pickerStyle(.segmented)
                
                // MARK: - Conteúdo da Seleção
                if segmentedControl == 0 {
                    NutritionFactsTable(
                        items: items,
                        servingsPerContainer: servingsPerContainer,
                        servingSizeText: servingSizeText
                    )
                } else {
                    CompositionIngredientCard(
                        ingredientsText: ingredientsText,
                        allergensText: allergensText
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 24)
        }
        .background(Color(.systemBackground))
    }
    
    // MARK: - Subviews
    
    private var productImageCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.gray.opacity(0.35))
                .frame(height: 260)
            
            if let imageURLString = ingredientImageURL, let url = URL(string: imageURLString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 260)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 130)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    IngredientView(
        ingredientTitle: "Chocolate Nescau - 350g",
        ingredientBrands: "Nestlé"
    )
    .environment(Router())
}

