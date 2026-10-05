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
        ZStack(alignment: .top) {
            
            ZStack {
                if let imageURLString = ingredientImageURL, let url = URL(string: imageURLString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFill()
                }
                Color.black.opacity(0.2)
            }
            .frame(height: 250)
            .clipped()
            .ignoresSafeArea(edges: .all)
            
            ScrollView {
                VStack(spacing: 0) {
                    
                    Color.clear
                        .frame(height: 250)
                    
                    VStack {
                        Text(ingredientTitle)
                            .foregroundStyle(.primary)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                        
                        Text(ingredientBrands)
                            .foregroundStyle(.secondary)
                            .fontWeight(.semibold)
                        
                        Picker("Informações", selection: $segmentedControl) {
                            Text("Informação nutricional").tag(0)
                            Text("Composição").tag(1)
                        }
                        .pickerStyle(.segmented)
                        .tint(.purple)
                        .padding(.vertical)
                        
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
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.background)
                    .clipShape(.rect(topLeadingRadius: 16, topTrailingRadius: 16))
                }
            }
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
            .onDisappear {
                UIScrollView.appearance().bounces = true
            }
            .ignoresSafeArea(edges: .top)
        }
        .background(.background)
    }
}

#Preview {
    IngredientView(
        ingredientTitle: "Chocolate Nescau - 350g",
        ingredientBrands: "Nestlé"
    )
    .environment(Router())
}

