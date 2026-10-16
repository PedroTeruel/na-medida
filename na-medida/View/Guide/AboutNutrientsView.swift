//
//  AboutNutrientsView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 06/10/26.
//

import SwiftUI

struct AboutNutrientsView: View {
    @Environment(Router.self) private var router
    @State var segmentedControl = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                Text("Definição dos Nutrientes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Descubra para que servem os principais nutrientes")
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                VStack(spacing: 16) {
                    ForEach(nutrients) { nutrient in
                        Button {
                            router.navigate(to: .nutrientInfo(nutrient))
                        } label: {
                            NutrientsCard(
                                nutrientName: nutrient.name,
                                nutrientDescription: nutrient.description,
                                nutrientImg: nutrient.image
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationStack {
        AboutNutrientsView()
            .environment(Router())
    }
}
