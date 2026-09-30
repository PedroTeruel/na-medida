//
//  SearchSheetView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 29/09/26.
//

import SwiftUI

struct SearchSheetView: View {
    @State private var searchField = ""
    @Binding var currentDetent: PresentationDetent
    
    var body: some View {
        NavigationStack {
            SearchAPIView(currentDetent: $currentDetent)
                .searchable(
                    text: $searchField,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Pesquisar ingrediente"
                )
        }
    }
}
