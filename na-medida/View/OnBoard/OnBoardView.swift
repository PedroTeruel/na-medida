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
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView{
                VStack(spacing: 0) {
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
                    .padding(.top, 40)
                    .padding(.horizontal, 16)
                    
                    ZStack {
                        WaveShape()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.95, green: 0.90, blue: 0.35), // Amarelo
                                        Color(red: 0.85, green: 0.65, blue: 0.85)  // Lilás / Rosa
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(height: 380)
                        
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 110)
                    }
                    
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
                    .padding(.bottom, 24)
                }
                .background(Color(.systemBackground))
            }
            .onTapGesture {
                isNameFieldFocused = false
            }
            .onChange(of: isNameFieldFocused) { _, focused in
                if focused {
                    withAnimation {
                        proxy.scrollTo(
                            "nameField",
                            anchor: .center
                        )
                    }
                }
            }
        }
    }
}

struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.height * 0.40))
        
        path.addCurve(
            to: CGPoint(x: rect.width, y: rect.height * 0.01),
            control1: CGPoint(x: rect.width * 0.45, y: rect.height * 0.55),
            control2: CGPoint(x: rect.width * 0.85, y: rect.height * 0.20)
        )
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.75))
        
        path.addCurve(
            to: CGPoint(x: 0, y: rect.height),
            control1: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5),
            control2: CGPoint(x: rect.width * 0.2, y: rect.height * 0.99)
        )
        
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    OnBoardView { name in
        print("Continuar com o nome: \(name)")
    }
}
