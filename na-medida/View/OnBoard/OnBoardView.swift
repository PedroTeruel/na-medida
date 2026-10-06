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
    @FocusState private var isNameFieldFocused: Bool
    
    private var backgroundGradient: some View {
        VStack{
            LinearGradient(
                stops: [
                    .init(color: Color.orange.opacity(0.20), location: 0.1),
                    .init(color: Color.purple.opacity(0.20), location: 0.8)
                ],
                startPoint: .topLeading,
                endPoint: .topTrailing
            )
            .frame(height: 260)
            //mask para gradiente nao ficar marcado na borda inferior
            .mask(
                LinearGradient(
                    stops: [
                        .init(color: .black, location: 0.4),       // Opacidade total no topo
                        .init(color: .black, location: 0.5),       // Mantém a cor intensa até a metade
                        .init(color: .clear, location: 1.0)        // Esmaece totalmente na borda inferior
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
            Spacer() // Mantém o gradiente fixado no topo da tela
        }
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ZStack{
                // gradiente no Topo
                backgroundGradient
                    .ignoresSafeArea()
                
                // 3. Conteúdo com Distribuição do Espaço
                GeometryReader { geometry in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            
                            // Cabeçalho (Topo)
                            VStack(spacing: 16) {
                                Text("Bem-vindo(a) ao\nNa Medida!")
                                    .font(.system(size: 28, weight: .heavy))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.primary)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                Text("Entender o que você consome não precisa ser complicado. Descubra a composição nutricional das suas receitas e dos produtos que você consome.")
                                    .font(.system(size: 17))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 24)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.top, 60)
                            .padding(.horizontal, 16)
                            
                            Spacer() // Empurra a imagem para o centro
                            
                            // Ícone (Centro)
                            Image("iconeOnBoard")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 180)
                            
                            Spacer() // Empurra a seção de entrada para a parte inferior
                            
                            // Entrada do Nome e Botão (Rodapé)
                            VStack(spacing: 16) {
                                Text("Como podemos te chamar?")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.primary)
                                
                                TextField("Digite seu nome", text: $username)
                                    .focused($isNameFieldFocused)
                                    .id("nameField")
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .cornerRadius(25)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                    )
                                
                                Button(action: {
                                    onContinue(username)
                                }) {
                                    Text("Continuar")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                        .background(Color("buttonColor"))
                                        .cornerRadius(25)
                                }
                                .disabled(username.trimmingCharacters(in: .whitespaces).isEmpty)
                                .opacity(username.trimmingCharacters(in: .whitespaces).isEmpty ? 0.6 : 1.0)
                            }
                            .padding(.horizontal, 42)
                            .padding(.bottom, 60)
                        }
                        // Garante que a VStack ocupe no mínimo a altura total disponível do ecrã
                        .frame(minHeight: geometry.size.height)
                    }
                }
            }
            .onTapGesture {
                isNameFieldFocused = false
            }
            .onChange(of: isNameFieldFocused) { _, focused in
                if focused {
                    withAnimation {
                        proxy.scrollTo("nameField", anchor: .center)
                    }
                }
            }
        }
    }
}

#Preview {
    OnBoardView { name in
        print("Continuar com o nome: \(name)")
    }
}
