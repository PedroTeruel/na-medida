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
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                
                Text("Conheça um pouco mais sobre nosso app e seus idealizadores.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                aboutAppCard
                
                teamCard
                
                creditsCard
                
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
                    Text("Equipe")
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
            
            VStack {
                HStack {
                    Image("photoGui")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                    
                    VStack (alignment: .leading) {
                        Text("Guilherme Sales")
                            .font(.headline)
                        Text("Designer")
                            .font(.subheadline)
                    }
                }
            }
            
            VStack {
                HStack {
                    Image("photoRebeca")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                    
                    VStack (alignment: .leading) {
                        Text("Rebeca Calmon")
                            .font(.headline)
                        Text("Desenvolvedora")
                            .font(.subheadline)
                    }
                }
            }
            VStack {
                HStack {
                    Image("photoTeruel")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                    
                    VStack (alignment: .leading) {
                        Text("Pedro Teruel")
                            .font(.headline)
                        Text("Desenvolvedor")
                            .font(.subheadline)
                    }
                }
            }
            VStack {
                HStack {
                    Image("photoVitor")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                    
                    VStack (alignment: .leading) {
                        Text("Vitor Souza")
                            .font(.headline)
                        Text("Desenvolvedor")
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardBackground)
        .overlay(cardBorder)
    }
    
    private var creditsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 14) {
                Image(systemName: "books.vertical.fill")
                    .font(.title3)
                    .foregroundStyle(.orange)
                    .frame(width: 46, height: 46)
                    .background {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(.orange.opacity(0.12))
                    }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Créditos e Licenças")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                    
                    Text("Fontes de dados e atribuições")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer(minLength: 0)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Open Food Facts")
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text("Base de dados colaborativa e aberta de produtos alimentares utilizada para a busca e leitura de códigos de barras.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineSpacing(3)
                
                if let offURL = URL(string: "https://br.openfoodfacts.org") {
                    Link(destination: offURL) {
                        HStack(spacing: 6) {
                            Text("Acessar Open Food Facts")
                            Image(systemName: "arrow.up.right")
                        }
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.button)
                    }
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Tabela TACO (JSON)")
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text("Dados da Tabela Brasileira de Composição de Alimentos (NEPA/UNICAMP) convertidos para formato JSON por Marcelo Santos.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineSpacing(3)
                
                if let tacoURL = URL(string: "https://github.com/marcelosanto/tabela_taco") {
                    Link(destination: tacoURL) {
                        HStack(spacing: 6) {
                            Text("Repositório no GitHub (Marcelo Santos)")
                            Image(systemName: "arrow.up.right")
                        }
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.button)
                    }
                }
            }
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
