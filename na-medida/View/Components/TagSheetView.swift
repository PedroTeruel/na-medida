//
//  TagSheetView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 29/09/26.
//

import SwiftUI

struct TagSheetView: View {
    var cancelAction: () -> Void
    var confirmAction: () -> Void
    
    var body: some View {
        
        NavigationStack {
            Text("teste")
                .navigationTitle("Adicionar Categoria")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: cancelAction) {
                            Image(systemName: "xmark")
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: confirmAction) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
        }
    }
}
