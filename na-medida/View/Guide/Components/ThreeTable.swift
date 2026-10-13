//
//  ThreeTable.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 02/10/26.
//

import SwiftUI

struct ThreeTable: View {
    
    var version: Int
    
    private var selectedMeasures: [Measure] {
        switch version {
        case 0:
            return measureSolid
        case 1:
            return measureSauce
        default:
            return []
        }
    }
    
    struct Measure: Identifiable {
        let id = UUID()
        let name: String
        let cup: String
        let spoon: String
    }
    
    private let measureSolid: [Measure] = [
        .init(
            name: "Farinha de Trigo",
            cup: "120 g",
            spoon: "8 g"
        ),
        .init(
            name: "Açúcar Refinado",
            cup: "200 g",
            spoon: "12 g"
        ),
        .init(
            name: "Açúcar Mascavo",
            cup: "150 g",
            spoon: "10 g"
        ),
        .init(
            name: "Margarina",
            cup: "200 g",
            spoon: "15 g"
        ),
        .init(
            name: "Cacau em Pó",
            cup: "90 g",
            spoon: "6 g"
        ),
        .init(
            name: "Aveia em Flocos",
            cup: "80 g",
            spoon: "5 g"
        ),
        .init(
            name: "Arroz Cru",
            cup: "200 g",
            spoon: "15 g"
        )
    ]
    
    private let measureSauce: [Measure] = [
        .init(
            name: "Sal Fino",
            cup: "15 g",
            spoon: "5 g"
        ),
        .init(
            name: "Sal Grosso",
            cup: "20 g",
            spoon: "7 g"
        ),
        .init(
            name: "Fermento",
            cup: "12g",
            spoon: "4 g"
        ),
        .init(
            name: "Bicarbonato",
            cup: "14 g",
            spoon: "5 g"
        ),
        .init(
            name: "Especiarias",
            cup: "6 g",
            spoon: "2 g"
        ),
        .init(
            name: "Ervas",
            cup: "3 g",
            spoon: "1 g"
        )
    ]
    
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
                    
                    Text("Medidas de Sólidos")
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
                .fill(.background)
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
