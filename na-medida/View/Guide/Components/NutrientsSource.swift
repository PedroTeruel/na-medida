//
//  NutrientsSource.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 08/10/26.
//

import SwiftUI

struct NutrientsSource: View {
    var sourceName: String
    var sourceIcon: String
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack(){
                VStack(spacing: 12){
                    Image(sourceIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                    Text(sourceName)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 80, height: 120)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.quinary)
                )
                
            }
            
        }
    }
}

#Preview {
    NutrientsSource(sourceName: "Peixes Gordurosos", sourceIcon: "")
}
