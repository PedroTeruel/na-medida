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
        
        VStack(spacing: 16) {
            Text("Como podemos te chamar?")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
            
            TextField("Digite seu nome", text: $newUsername)
                .id("nameField")
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(25)
                .autocorrectionDisabled()
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
            
            Button(action: {
                onConfirm(newUsername)
                dismiss()
            }) {
                Text("Continuar")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color("buttonColor"))
                    .cornerRadius(25)
            }
            .disabled(newUsername.trimmingCharacters(in: .whitespaces).isEmpty)
            .opacity(newUsername.trimmingCharacters(in: .whitespaces).isEmpty ? 0.6 : 1.0)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button{
                    dismiss()
                } label:{
                    Image(systemName: "checkmark")
                }
                .buttonStyle(.glassProminent)
            }
        }
        .padding(.horizontal, 42)
        .padding(.top, 44)
        
        Spacer()
    }
}

#Preview {
    EditNameSheet { newUsername in
        print("Novo nome:", newUsername)
    }
}
