//
//  SearchBarComponent.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 03/10/26.
//

import SwiftUI

struct SearchBarComponent: View {
    @Binding var searchText: String
    var isSearchFocused: FocusState<Bool>.Binding
    var onSearchSubmit: (String) -> Void
    
    var body: some View {
        HStack (spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.primary)
                
                TextField("Pesquisar ingrediente", text: $searchText)
                    .submitLabel(.search)
                    .autocorrectionDisabled()
                    .focused(isSearchFocused)
                    .onSubmit {
                        onSearchSubmit(searchText)
                    }
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .frame(height: 44)
            .background(Color(.systemGray5))
            .cornerRadius(22)
            .glassEffect()
            
            if isSearchFocused.wrappedValue {
                Button {
                    isSearchFocused.wrappedValue = false
                    searchText = ""
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 22, weight: .regular))
                        .frame(width: 44, height: 44)
                        .foregroundColor(.primary)
                        .background(Color(.systemGray5))
                        .cornerRadius(22)
                        .glassEffect()
                }
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .padding(.horizontal)
        .padding(.top, 16)
        .padding(.bottom, 16)
        .animation(.default, value: isSearchFocused.wrappedValue)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var text = ""
        @FocusState private var isFocused: Bool
        
        var body: some View {
            SearchBarComponent(
                searchText: $text,
                isSearchFocused: $isFocused,
                onSearchSubmit: { _ in }
            )
        }
    }
    return PreviewWrapper()
}
