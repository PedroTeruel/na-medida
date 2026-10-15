//
//  AboutView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 05/10/26.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let supportEmail = "Sousa.guilherme850@gmail.com"
    
    private let teamMembers = [
        "Guilherme Sales",
        "Pedro Teruel",
        "Rebeca Calmon",
        "Vitor Souza"
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                
                Text("Conheça um pouco mais sobre nosso app e seus idealizadores.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                aboutAppCard
                
                teamCard
                
                contactCard
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
        .navigationTitle("Sobre nós")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var aboutAppCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 14) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 46, height: 46)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                
                Text("O que é o Na Medida?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                
                Spacer(minLength: 0)
            }
            
            Divider()
            
            Text("Na Medida é um aplicativo que permite escanear e pesquisar produtos alimentícios usados no dia a dia e fornecer uma estimativa dos nutrientes de receitas feitas por você.")
                .font(.body)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack(spacing: 18) {
                Image(systemName: "lightbulb.max.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 36)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.yellow, .orange)
                
                Text("Nosso objetivo é tornar o acesso a essas informações mais simples e prático, incentivando você a ter mais consciência da composição nutricional das receitas que prepara.")
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.yellow.opacity(0.2))
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardBackground)
        .overlay(cardBorder)
    }
    
    private var teamCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 14) {
                Image(systemName: "person.3.fill")
                    .font(.title3)
                    .foregroundStyle(.blue)
                    .frame(width: 46, height: 46)
                    .background {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(.blue.opacity(0.12))
                    }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Equipe desenvolvedora")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                    
                    Text("Idealizadores do projeto")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer(minLength: 0)
            }
            
            Divider()
            
            Image("aboutUsPhoto")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 18))
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardBackground)
        .overlay(cardBorder)
    }
    
    private var contactCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 14) {
                Image(systemName: "envelope.fill")
                    .font(.title3)
                    .foregroundStyle(.button)
                    .frame(width: 46, height: 46)
                    .background {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.button.opacity(0.12))
                    }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Nosso contato")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                    
                    Text("Dúvidas, sugestões ou suporte")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer(minLength: 0)
            }
            
            Divider()
                .padding(.vertical, 4)
            
            Text("Em caso de dúvidas, sugestões ou feedback sobre o Na Medida, entre em contato diretamente com a nossa equipe:")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(3)
            
            if let emailURL = URL(string: "mailto:\(supportEmail)") {
                Link(destination: emailURL) {
                    HStack {
                        Text(supportEmail)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "arrow.up.right")
                            .font(.subheadline.bold())
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(.button, in: RoundedRectangle(cornerRadius: 16))
                }
                .padding(.top, 4)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardBackground)
        .overlay(cardBorder)
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(colorScheme == .dark ? Color(.secondarySystemBackground) : .white)
            .shadow(
                color: .black.opacity(0.08),
                radius: 10,
                x: 0,
                y: 4
            )
    }
    
    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: 24)
            .stroke(.secondary.opacity(0.2), lineWidth: 1.5)
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
