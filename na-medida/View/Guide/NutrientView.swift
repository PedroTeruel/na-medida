//
//  NutrientView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 06/10/26.
//

import SwiftUI

struct NutrientView: View {
    @State private var segmentedControl = 0
    let nutrient: Nutrient
    
    var body: some View{
        
        ScrollView{
            VStack(spacing: 24){
                VStack(spacing: 10){
                    Image(nutrient.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                    
                    Text(nutrient.name)
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    Text(nutrient.description)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: 280)
                
                Picker(
                    "Informações",
                    selection: $segmentedControl
                ) {
                    Text("Visão Geral")
                        .tag(0)
                    
                    Text("Fontes")
                        .tag(1)
                }
                .pickerStyle(.segmented)
                if segmentedControl == 0{
                    VStack(alignment: .leading, spacing: 24){
                        NutrientGenereal(
                            generalBody: nutrient.generalBody,
                            generalCap: nutrient.generalCap,
                            generalColor: nutrient.generalColor
                        )
                        VStack(
                            alignment: .leading,
                            spacing: 12
                        ) {
                            Text("Principais Funções")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                            ForEach(nutrient.functions){ function in
                                FuncCard(
                                    funcIcon: function.icon,
                                    funcText: function.text
                                )
                            }
                        }
                    }
                } else{
                    
                    
                    VStack(alignment: .leading, spacing: 16){
                        Text("Principais Fontes")
                            .font(.title3)
                            .fontWeight(.semibold)
                        FlowLayout(spacing: 12, rowSpacing: 12){
                            ForEach(nutrient.sources, id: \.self) { source in
                                
                                NutrientsSource(
                                    sourceName: source
                                )
                            }
                        }
                        MeasureWarningCard()
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview{
    
    NavigationStack{
        
        NutrientView(
            nutrient: nutrients[3]
        )
    }
}
