//
//  AboutView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 05/10/26.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Sobre nós")
                        .font(.title)
                        .foregroundStyle(.primary)
                        .fontWeight(.bold)
                    
                    Text("Conheça um pouco mais sobre nosso app e seus idealizadores")
                        .font(.subheadline.italic())
                        .foregroundStyle(.primary)
                        .fontWeight(.thin)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("O que é o Na Medida?")
                        .font(.title3)
                        .foregroundStyle(.primary)
                        .fontWeight(.bold)
                    
                    Text("Na Medida é um aplicativo que permite escanear e pesquisar produtos alimentícios usados no dia-a-dia e fornecer uma estimativa dos nutrientes de receitas feitas por você. \nO objetivo do Na Medida é tornar o acesso a essas informações mais simples e prático, te incentivando a ter mais consciência da composição nutricional de receitas que você prepara.")
                        .font(.body)
                        .foregroundStyle(.primary)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Equipe desenvolvedora")
                        .font(.title3)
                        .foregroundStyle(.primary)
                        .fontWeight(.bold)
                    
                    Image("aboutUsPhoto")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, -16)
                }
                
//                VStack(alignment: .leading, spacing: 16) {
//                    Text("Nosso contato")
//                        .font(.title3)
//                        .foregroundStyle(.primary)
//                        .fontWeight(.bold)
//                    
//                    Text("Em caso de dúvidas, sugestões ou blablablabalba contate o senac")
//                        .font(.body)
//                        .foregroundStyle(.primary)
//                }
            }
            .padding(16)
        }
    }
}
#Preview {
    AboutView()
}
