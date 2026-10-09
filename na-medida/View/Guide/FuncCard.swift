//
//  FuncCard.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 08/10/26.
//

import SwiftUI

struct FuncCard: View {
        
    struct NutrientS{
        let funcIcon: String
        let funcText: String
    }
    
    private let fat: [NutrientS] = [
        .init(
            funcIcon: "RayIcon",
            funcText: "Fonte de energia"
        )
    ]
    
    private let carb: [NutrientS] = [
        .init(
            funcIcon: "RayIcon",
            funcText: "Fonte de energia"
        )
    ]
    private let cal: [NutrientS] = [
        .init(
            funcIcon: "RayIcon",
            funcText: "Fonte de energia"
        )
    ]
    
    private let prot: [NutrientS] = [
        .init(
            funcIcon: "RayIcon",
            funcText: "Fonte de energia"
        )
    ]
    
    private let sod: [NutrientS] = [
        .init(
            funcIcon: "RayIcon",
            funcText: "Fonte de energia"
        )
    ]
    
    var funcIcon: String
    var funcText: String
    var body: some View {
        HStack(spacing: 22){
            Image(funcIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            Text(funcText)
            Spacer()
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.quinary.opacity(0.5))
        )
    }
    
}

#Preview {
    FuncCard(funcIcon: "RayIcon", funcText: "Fonte de energia")
}
