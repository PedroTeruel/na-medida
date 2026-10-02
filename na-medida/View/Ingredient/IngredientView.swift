//
//  IngredientView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 30/09/26.
//

//import SwiftUI
//
//struct IngredientView: View {
//    @Environment(Router.self) private var router
//    
//    @State private var segmentedControl = 0
//    var ingredientTitle: String
//    var ingredientBrands: String
//    var ingredientImageURL: String?
//    
//    init(
//        ingredientTitle: String = "Titulo do Ingrediente",
//        ingredientBrands: String = "Marca",
//        ingredientImageURL: String? = nil
//    ) {
//        self.ingredientTitle = ingredientTitle
//        self.ingredientBrands = ingredientBrands
//        self.ingredientImageURL = ingredientImageURL
//        
//        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.button
//        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBackground], for: .selected)
//        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
//    }
//    
//    var body: some View {
//        ZStack(alignment: .top) {
//            
//            ZStack {
//                if let imageURLString = ingredientImageURL, let url = URL(string: imageURLString) {
//                    AsyncImage(url: url) { image in
//                        image
//                            .resizable()
//                            .scaledToFill()
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    
//                } else {
//                    Image(systemName: "photo")
//                        .resizable()
//                        .scaledToFill()
//                }
//                Color.black.opacity(0.3)
//            }
//            .frame(height: 300)
//            .clipped()
//            .ignoresSafeArea(edges: .top)
//            
//            ScrollView {
//                VStack(spacing: 0) {
//                    
//                    Color.clear
//                        .frame(height: 250)
//                    
//                    VStack {
//                        Text(ingredientTitle)//Com API produtoDaApi.productName
//                            .foregroundStyle(.primary)
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                            .multilineTextAlignment(.center)
//                            .padding(.top, 10)
//                        
//                        Text(ingredientBrands)//Com API produtoDaApi.brands
//                            .foregroundStyle(.secondary)
//                            .fontWeight(.semibold)
//                        
//                        Picker("Informações", selection: $segmentedControl) {
//                            Text("Informação nutricional").tag(0)
//                            Text("Composição").tag(1)
//                        }
//                        .pickerStyle(.segmented)
//                        .tint(.purple)
//                        .padding(.vertical)
//                        
//                        if segmentedControl == 0 {
//                            Text("Tabela com informacoes nutricionais")
//                        } else {
//                            Text("Ingredientes e Alergenicos")
//                        }
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(.background)
//                    .clipShape(.rect(topLeadingRadius: 16, topTrailingRadius: 16))
//                }
//            }
//            .onAppear {
//                UIScrollView.appearance().bounces = false
//            }
//            .onDisappear {
//                UIScrollView.appearance().bounces = true
//            }
//            .ignoresSafeArea(edges: .top)
//        }
//        .background(.background)
//    }
//}
//
//#Preview {
//    IngredientView(
//        ingredientTitle: "Chocolate Nescau - 350g",
//        ingredientBrands: "Nestlé")
//    .environment(Router())
//}

import SwiftUI

struct IngredientView: View {
    @Environment(Router.self) private var router
    
    @State private var segmentedControl = 0
    var ingredientTitle: String
    var ingredientBrands: String
    var ingredientImageURL: String?
    
    // Propriedades para os componentes de tabela e composição
    var items: [NutritionalFactsItem]
    var servingsPerContainer: String?
    var servingSizeText: String?
    var ingredientsText: String
    
    // MARK: - Inicializador Principal
    init(
        ingredientTitle: String = "Titulo do Ingrediente",
        ingredientBrands: String = "Marca",
        ingredientImageURL: String? = nil,
        items: [NutritionalFactsItem] = [],
        servingsPerContainer: String? = nil,
        servingSizeText: String? = nil,
        ingredientsText: String = ""
    ) {
        self.ingredientTitle = ingredientTitle
        self.ingredientBrands = ingredientBrands
        self.ingredientImageURL = ingredientImageURL
        self.items = items
        self.servingsPerContainer = servingsPerContainer
        self.servingSizeText = servingSizeText
        self.ingredientsText = ingredientsText
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.button
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBackground], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
    }
    
    // MARK: - Inicializador Direto da DTO Corrigido
        init(productDTO: ProductOpenFoodFactsDTO) {
            self.init(
                ingredientTitle: productDTO.productName ?? "Título Indisponível",
                ingredientBrands: productDTO.brands ?? "Marca não informada",
                ingredientImageURL: productDTO.fotoProdutoURL,
                items: productDTO.nutritionalItems,
                servingsPerContainer: nil, // Campo não presente na DTO atual
                servingSizeText: productDTO.servingSize,
                ingredientsText: productDTO.composicaoProduto ?? ""
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
                        
                        // MARK: - Componentes dinâmicos com dados repassados
                        if segmentedControl == 0 {
                            NutritionFactsTable(
                                items: items,
                                servingsPerContainer: servingsPerContainer,
                                servingSizeText: servingSizeText
                            )
                        } else {
                            CompositionIngredientCard(
                                ingredientsText: ingredientsText
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

// MARK: - Preview (Xcode Canvas)
#Preview {
    IngredientView(
        ingredientTitle: "Chocolate Nescau - 350g",
        ingredientBrands: "Nestlé"
    )
    .environment(Router())
}

