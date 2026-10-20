//
//  ThreeTable.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 02/10/26.
//

import SwiftUI

struct ThreeTable: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var version: Int
    
    private var selectedMeasures: [SolidMeasure] {
        switch version {
        case 0:
            return MeasureData.solidMeasures
        case 1:
            return MeasureData.sauceMeasures
        default:
            return []
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack(spacing: 16) {
                
                Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                    .font(.title2)
                    .foregroundStyle(.blue)
                    .frame(width: 56, height: 56)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.blue.opacity(0.1))
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("Guia de Medidas Caseiras")
                        .font(.headline)
                    
                    Text(
                        "Veja equivalências entre gramas e medidas caseiras mais comuns."
                    )
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
            }
            .padding()
            
            VStack(spacing: 0) {
                
                HStack(spacing: 22) {
                    
                    Text("Ingrediente")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    VStack(){
                        Image(systemName: "cup.and.saucer")
                            .frame(height: 12)
                        Text("1 Xícara de Chá")
                            .font(.caption2)
                    }
                    
                    VStack(){
                        Image(systemName: "spoon.serving")
                            .frame(height: 12)
                        Text("1 Colher de Sopa")
                            .font(.caption2)
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 16)
                .padding(.vertical, 18)
                .background {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.blue.opacity(0.07))
                }
                
                ForEach(Array(selectedMeasures.enumerated()), id: \.element.id) { index, measure in
                    
                    HStack(spacing: 8) {
                        
                        HStack(spacing: 12) {
                            
                            Text(measure.name)
                                .font(.footnote)
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        
                        Text(measure.cup)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .center
                            )
                            .padding(.leading, 40)
                        
                        VStack(alignment:.center){
                            Text(measure.spoon)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .trailing
                                )
                                .padding(.trailing, 26)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    
                    if index != selectedMeasures.count - 1 {
                        Divider()
                            .padding(.horizontal)
                    }
                    
                }
            }
            .padding(.bottom, 8)
            .padding(.horizontal, 4)
        }
        .background {
            RoundedRectangle(cornerRadius: 28)
                .fill(colorScheme == .dark ? Color(.secondarySystemBackground) : .white)
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 10,
                    x: 0,
                    y: 4
                )
        }
    }
}

#Preview {
    ThreeTable(version: 1)
}
