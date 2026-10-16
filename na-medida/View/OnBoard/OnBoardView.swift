//
//  OnBoardView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 30/09/26.
//

import SwiftUI

// Enum para controlar qual documento legal abrir na Sheet
enum LegalDocument: Identifiable {
    case terms
    case privacy
    
    var id: String {
        switch self {
        case .terms: return "terms"
        case .privacy: return "privacy"
        }
    }
    
    var title: String {
        switch self {
        case .terms: return "Termos de Uso"
        case .privacy: return "Política de Privacidade"
        }
    }
}

struct OnBoardView: View {
    @State private var username = ""
    let onContinue: (String) -> Void
    @FocusState private var isNameFieldFocused: Bool
    
    // Estado para controlar qual sheet abrir
    @State private var selectedDocument: LegalDocument?
    
    private var backgroundGradient: some View {
        VStack {
            LinearGradient(
                stops: [
                    .init(color: Color.orange.opacity(0.20), location: 0.1),
                    .init(color: Color.purple.opacity(0.20), location: 0.8)
                ],
                startPoint: .topLeading,
                endPoint: .topTrailing
            )
            .frame(height: 260)
            .mask(
                LinearGradient(
                    stops: [
                        .init(color: .black, location: 0.4),
                        .init(color: .black, location: 0.5),
                        .init(color: .clear, location: 1.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
            Spacer()
        }
    }
    
    // Texto inferior com links interativos para os Termos e Privacidade
    private var legalAttributedString: AttributedString {
        var fullText = AttributedString("Ao clicar em prosseguir ou \"Prefiro não informar\", o usuário está concordando com os Termos de Uso e Política de Privacidade.")
        
        fullText.font = .footnote
        fullText.foregroundColor = .secondary
        
        if let termsRange = fullText.range(of: "Termos de Uso") {
            fullText[termsRange].foregroundColor = .blue
            fullText[termsRange].underlineStyle = .single
            fullText[termsRange].link = URL(string: "customLink://terms")
        }
        
        if let privacyRange = fullText.range(of: "Política de Privacidade") {
            fullText[privacyRange].foregroundColor = .blue
            fullText[privacyRange].underlineStyle = .single
            fullText[privacyRange].link = URL(string: "customLink://privacy")
        }
        
        return fullText
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()
                
                GeometryReader { geometry in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            
                            VStack(spacing: 16) {
                                Text("Bem-vindo(a) ao\nNa Medida!")
                                    .font(.system(size: 28, weight: .heavy))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.primary)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                Text("Entender o que você consome não precisa ser complicado. Descubra a composição nutricional das suas receitas e dos produtos que você consome!")
                                    .font(.system(size: 17))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 24)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.top, 60)
                            .padding(.horizontal, 16)
                            
                            Spacer()
                            
                            Image("iconeOnBoard")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 160)
                                
                            
                            Spacer()
                            
                            VStack(spacing: 16) {
                                Text("Como podemos te chamar?")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.primary)
                                
                                TextField("Digite seu nome", text: $username)
                                    .focused($isNameFieldFocused)
                                    .id("nameField")
                                    .onChange(of: username) { _, newValue in
                                        username = String(newValue.prefix(20))
                                    }
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .cornerRadius(25)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                    )
                                    .autocorrectionDisabled()
                                
                                VStack(spacing: 20) {
                                    Button(action: {
                                        onContinue(username)
                                    }) {
                                        Text("Prosseguir")
                                            .font(.system(size: 17, weight: .semibold))
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 16)
                                            .background(Color("buttonColor"))
                                            .cornerRadius(25)
                                    }
                                    .disabled(username.trimmingCharacters(in: .whitespaces).isEmpty)
                                    .opacity(username.trimmingCharacters(in: .whitespaces).isEmpty ? 0.6 : 1.0)
                                    
                                    Button(action: {
                                        onContinue("Visitante")
                                    }) {
                                        Text("Prefiro não informar")
                                            .font(.system(size: 17, weight: .semibold))
                                            .foregroundStyle(.blue)
                                            .underline()
                                    }
                                    
                                    // Texto legal clicável integrado via AttributedString
                                    Text(legalAttributedString)
                                        .multilineTextAlignment(.center)
                                        .padding(.top, 8)
                                        .environment(\.openURL, OpenURLAction { url in
                                            if url.absoluteString == "customLink://terms" {
                                                selectedDocument = .terms
                                                return .handled
                                            } else if url.absoluteString == "customLink://privacy" {
                                                selectedDocument = .privacy
                                                return .handled
                                            }
                                            return .systemAction
                                        })
                                }
                            }
                            .padding(.horizontal, 36)
                            .padding(.bottom, 40)
                        }
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
            // Sheet nativa que renderiza o respetivo componente SwiftUI
            .sheet(item: $selectedDocument) { doc in
                NavigationStack {
                    Group {
                        switch doc {
                        case .terms:
                            TermsOfUseView() // O teu componente estruturado com cartões
                        case .privacy:
                            PrivacyPolicyView() // O componente equivalente para a política
                        }
                    }
                    .toolbar {
                                ToolbarItem(placement: .topBarTrailing) {
                                    Button {
                                        selectedDocument = nil
                                    } label: {
                                        Image(systemName: "xmark")
                                            .font(.title3)
                                            .foregroundStyle(.secondary)
                            }
                        }
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
