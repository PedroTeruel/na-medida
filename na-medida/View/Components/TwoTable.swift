//
//  TwoTable.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 07/10/26.
//

import SwiftUI

struct TwoTable: View {

    struct Measure: Identifiable {
        let id = UUID()
        let name: String
        let value: String
    }
    
    private let measureLiquid: [Measure] = [
        .init(
            name: "1 Xícara de Chá",
            value: "250"
        ),
        .init(
            name: "1/2 Xícara de Chá",
            value: "120"
        ),
        .init(
            name: "1/4 Xícara de Chá",
            value: "60"
        ),
        .init(
            name: "1 Colher de Sopa",
            value: "15"
        ),
        .init(
            name: "1 Colher de Chá",
            value: "5"
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

                    Text("Medida Caseira")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    VStack(){
                        Text("Mililítros")
                            .font(.footnote)
                        Text("(mL)")
                            .font(.caption)
                    }
                }
                .foregroundStyle(.secondary)
                .padding(.horizontal, 16)
                .padding(.vertical, 18)
                .background {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.blue.opacity(0.07))
                }

                ForEach(Array(measureLiquid.enumerated()), id: \.element.id) { index, measure in

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

                        VStack(alignment:.center){
                            Text(measure.value)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .trailing
                                )
                                .padding(.trailing, 14)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)

                    if index != measureLiquid.count - 1 {
                        Divider()
                            .padding(.horizontal)
                    }
                    
                }
            }
            .padding(.bottom, 8)
            .padding(.horizontal, 4)
        }
        //.padding(16)
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
        //.padding(.horizontal)
    }
}

#Preview {
    TwoTable()
}
