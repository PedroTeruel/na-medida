//
//  MeasureWarningCard.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 06/10/26.
//

import Foundation
import SwiftUI

struct MeasureWarningCard: View{
    var cardTitle: String = "As medidas podem variar"
    var cardBody: String = "Os valores são aproximados e podem mudar conforme a marca e o tipo do ingrediente."
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: "info.circle.fill")
                    .foregroundStyle(.blue)
            }
            VStack(alignment: .leading, spacing: 8){
                Text(cardTitle)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
                
                Text(cardBody)
                    .font(.callout)
                    .fontWeight(.regular)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(.blue.opacity(0.1))
        }
    }
}

#Preview {
    MeasureWarningCard(cardTitle: "As medidas podem variar", cardBody: "Os valores são aproximados e podem mudar conforme a marca e o tipo do ingrediente.")
}

