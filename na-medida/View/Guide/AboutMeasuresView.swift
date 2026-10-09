//
//  AboutMeasuresView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 06/10/26.
//

import SwiftUI

struct AboutMeasuresView: View {
    @State var segmentedControl = 0
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading, spacing: 22){
                Text("Aprenda a converter a quantidade de ingredientes usando medidas caseiras.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                Picker("Informações", selection: $segmentedControl) {
                    Text("Liquidos").tag(0)
                    Text("Solidos").tag(1)
                    Text("Temperos").tag(2)
                }
                .pickerStyle(.segmented)
                
                if segmentedControl == 0 {
                    ThreeTable(version: 0)
                } else if segmentedControl == 1 {
                    ThreeTable(version: 1)
                } else{
                    TwoTable()
                }
                MeasureWarningCard()
                
            }
            .padding(.horizontal)
            .navigationTitle("Tabela de Medidas")
            .navigationBarTitleDisplayMode(.large)
        }
        
    }
}

#Preview {
    AboutMeasuresView()
}
