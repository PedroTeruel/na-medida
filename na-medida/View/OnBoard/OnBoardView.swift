//
//  OnBoardView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 30/09/26.
//

import SwiftUI

struct OnBoardView: View {
    
    @State private var username = ""
    let onContinue: (String) -> Void
    
    var body: some View {
        Text("Qual é o seu nome?")
        TextField("Nome", text:$username)
        
        Button(username) {
            onContinue(username)
        }
        .buttonStyle(.bordered)
    }
}

//#Preview {
//    OnBoardView(self.name)
//}
