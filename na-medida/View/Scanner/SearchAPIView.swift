//
//  SearchAPIView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 29/09/26.
//

import SwiftUI

struct SearchAPIView: View {
    @Binding var currentDetent: PresentationDetent
    @Environment(\.isSearching) private var isSearching
    
    var body: some View {
        List {
            Text("Ingrediente1")
            Text("Ingrediente2")
        }
        .navigationTitle("Busque um ingrediente")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: isSearching) { _, isFocused in
            if isFocused {
                currentDetent = .large
            }
        }
    }
}
