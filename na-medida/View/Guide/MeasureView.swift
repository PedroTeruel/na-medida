//
//  MeasureView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 06/10/26.
//

import SwiftUI

struct MeasureView: View {
    var body: some View {
        @State var segmentedControl = 0
        NavigationStack{
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
                    
                } else if segmentedControl == 1 {
                    
                } else{
                    
                }
                MeasureWarningCard()
            }
            .navigationTitle("Tabela de Medidas")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    MeasureView()
}
