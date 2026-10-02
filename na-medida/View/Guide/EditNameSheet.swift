//
//  EditNameSheet.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 02/10/26.
//

import SwiftUI

struct EditNameSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var newUsername: String = ""

    let onConfirm: (String) -> Void

    var body: some View {
        VStack {
            Text("Qual é o seu nome?")

            TextField("Nome", text: $newUsername)

            Button("Confirmar") {
                onConfirm(newUsername)
                dismiss()
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    EditNameSheet { newUsername in
        print("Novo nome:", newUsername)
    }
}
