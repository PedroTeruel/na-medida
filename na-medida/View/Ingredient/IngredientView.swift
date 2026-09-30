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
    var ingredientTitle: String = "Titulo do Ingrediente"
    var ingredientBrands: String = "Marca"
    
    init(ingredientTitle: String = "Titulo do Ingrediente", ingredientBrands: String = "Marca") {
        self.ingredientTitle = ingredientTitle
        self.ingredientBrands = ingredientBrands
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.button
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            ZStack {
                Image("Nescau")
                    .resizable()
                    .scaledToFill()
                Color.black.opacity(0.3)
            }
            .frame(height: 300)
            .clipped()
            .ignoresSafeArea(edges: .top)
            
            ScrollView {
                VStack(spacing: 0) {
                    
                    Color.clear
                        .frame(height: 250)
                    
                    VStack {
                        Text(ingredientTitle)//Com API produtoDaApi.productName
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                        
                        Text(ingredientBrands)//Com API produtoDaApi.brands
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                        
                        Picker("Informações", selection: $segmentedControl) {
                            Text("Informação nutricional").tag(0)
                            Text("Composição").tag(1)
                        }
                        .pickerStyle(.segmented)
                        .tint(.purple)
                        .padding(.vertical)
                        
                        if segmentedControl == 0 {
                            Text("Tabela com informacoes nutricionais")
                        } else {
                            Text("Ingredientes e Alergenicos")
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
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
        .background(Color.white)
    }
}
#Preview {
    IngredientView(
        ingredientTitle: "Chocolate Nescau - 350g",
        ingredientBrands: "Nestlé")
    .environment(Router())
}

