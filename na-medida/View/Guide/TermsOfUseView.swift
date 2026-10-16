//
//  TermsOfUseView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 05/10/26.
//

import SwiftUI

struct TermsClause: Identifiable {
    let id = UUID()
    let number: String
    var title: String? = nil
    let text: String
    var bullets: [String] = []
}

struct TermsSection: Identifiable {
    let id = UUID()
    let number: String
    let title: String
    let icon: String
    let tintColor: Color
    let clauses: [TermsClause]
}

struct TermsOfUseView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let supportEmail = "Sousa.guilherme850@gmail.com"
    
    private let sections: [TermsSection] = [
        TermsSection(
            number: "1",
            title: "Identificação do Desenvolvedor e Canal de Atendimento",
            icon: "person.2.badge.gearshape.fill",
            tintColor: .blue,
            clauses: [
                TermsClause(
                    number: "1.1.",
                    text: "O aplicativo Na Medida é desenvolvido por Guilherme Sales, Pedro Teruel, Rebeca Calmon e Vitor Souza, mantido e disponibilizado por Guilherme Sales."
                ),
                TermsClause(
                    number: "1.2.",
                    text: "Para suporte técnico, dúvidas, sugestões ou solicitações relativas a estes Termos de Uso ou ao tratamento de dados, o usuário poderá entrar em contato diretamente pelo e-mail oficial: Sousa.guilherme850@gmail.com"
                )
            ]
        ),
        TermsSection(
            number: "2",
            title: "Objeto e Mecanismo de Adesão aos Termos",
            icon: "doc.text.magnifyingglass",
            tintColor: .orange,
            clauses: [
                TermsClause(
                    number: "2.1.",
                    title: "Objeto",
                    text: "Estes Termos e Condições de Uso (\"Termos\") regem o acesso e a utilização do aplicativo Na Medida, ferramenta destinada à organização de receitas pessoais, consulta de macronutrientes, pesquisa de ingredientes e visualização de tabelas nutricionais."
                ),
                TermsClause(
                    number: "2.2.",
                    title: "Adesão",
                    text: "Ao utilizar nosso aplicativo, o usuário declara ter lido, compreendido e concordado integralmente com as condições aqui estabelecidas."
                ),
                TermsClause(
                    number: "2.3.",
                    title: "Política de Privacidade",
                    text: "O aplicativo Na Medida não coleta, usa ou armazena dados pessoais. O primeiro nome do usuário é solicitado apenas para personalização local da interface, mas informá-lo é opcional."
                ),
                TermsClause(
                    number: "2.4.",
                    title: "Discordância",
                    text: "Caso o usuário não concorde com qualquer disposição destes Termos, deverá abster-se de utilizar a aplicação."
                )
            ]
        ),
        TermsSection(
            number: "3",
            title: "Elegibilidade e Proteção a Menores",
            icon: "figure.and.child.holdinghands",
            tintColor: .purple,
            clauses: [
                TermsClause(
                    number: "3.1.",
                    title: "Idade Mínima",
                    text: "Embora o aplicativo Na Medida não faça a identificação etária, ele é direcionado a usuários com idade igual ou superior a 18 (dezoito) anos. A utilização por menores de 18 anos ou incapazes é recomendada mediante a supervisão e com a autorização prévia de seus pais ou responsáveis legais."
                )
            ]
        ),
        TermsSection(
            number: "4",
            title: "Descrição dos Serviços, Armazenamento Local e Minimização de Dados",
            icon: "iphone.and.arrow.forward",
            tintColor: .mint,
            clauses: [
                TermsClause(
                    number: "4.1.",
                    title: "Funcionalidades",
                    text: "O aplicativo oferece ferramentas para inserção manual de receitas, consulta a dados nutricionais estimados e organização de acervo culinário."
                ),
                TermsClause(
                    number: "4.2.",
                    title: "Armazenamento Puramente Local",
                    text: "O processamento e o armazenamento do acervo de receitas ocorrem localmente no próprio dispositivo móvel do usuário, não havendo sincronização centralizada em nuvem ou banco de dados externo de receitas de usuários."
                ),
                TermsClause(
                    number: "4.3.",
                    title: "Minimização de Dados Pessoais",
                    text: "Em cumprimento à Lei Geral de Proteção de Dados (LGPD - Lei nº 13.709/2018), solicita-se apenas o nome do usuário para fins de personalização da interface gráfica local."
                )
            ]
        ),
        TermsSection(
            number: "5",
            title: "Licença de Uso e Propriedade Intelectual",
            icon: "c.circle.fill",
            tintColor: .indigo,
            clauses: [
                TermsClause(
                    number: "5.1.",
                    title: "Concessão de Licença",
                    text: "Concede-se ao usuário uma licença de uso de software pessoal, limitada, não exclusiva, intransferível, não sublicenciável e revogável para utilização do aplicativo exclusivamente para fins pessoais e não comerciais (Código Civil, arts. 422 e 473; Lei de Software, Lei nº 9.609/1998)."
                ),
                TermsClause(
                    number: "5.2.",
                    title: "Propriedade Intelectual",
                    text: "O download e a instalação do aplicativo não transferem ao usuário qualquer direito de propriedade intelectual ou comercial sobre o software. Todo o código-fonte, arquitetura, design visual, marca, logotipo e ilustrações pertencem exclusivamente aos seus desenvolvedores."
                ),
                TermsClause(
                    number: "5.3.",
                    title: "Bases de Dados de Terceiros",
                    text: "As informações nutricionais disponibilizadas provêm de bases públicas abertas, incluindo a Tabela Brasileira de Composição de Alimentos (TACO), desenvolvida pelo NEPA/UNICAMP (https://nepa.unicamp.br/publicacoes) com estruturação em JSON por Marcelo Santos sob Licença MIT (Copyright © 2023 Marcelo Santos - https://github.com/marcelosanto/tabela_taco), e o Open Food Facts (https://br.openfoodfacts.org), disponibilizado sob a Open Database License (ODbL) e CC BY-SA, mantendo-se preservados todos os direitos autorais e créditos dos seus autores e mantenedores."
                )
            ]
        ),
        TermsSection(
            number: "6",
            title: "Regras de Conduta e Usos Proibidos",
            icon: "hand.raised.fill",
            tintColor: .red,
            clauses: [
                TermsClause(
                    number: "6.1.",
                    text: "Ao utilizar o aplicativo Na Medida, é expressamente vedado ao usuário:",
                    bullets: [
                        "Tentar realizar engenharia reversa, descompilação, cópia, alteração ou distribuição não autorizada do código-fonte do aplicativo;",
                        "Tentar burlar, desativar ou violar os mecanismos de segurança da aplicação;",
                        "Utilizar o aplicativo para atividades ilícitas, fraudulentas ou que infrinjam direitos de terceiros."
                    ]
                )
            ]
        ),
        TermsSection(
            number: "7",
            title: "Isenção e Limitação de Responsabilidade",
            icon: "exclamationmark.triangle.fill",
            tintColor: .yellow,
            clauses: [
                TermsClause(
                    number: "7.1.",
                    title: "Ausência de Propósito Médico e Clínico",
                    text: "O Na Medida é uma ferramenta puramente informativa e organizacional. O aplicativo NÃO possui propósito médico, clínico, terapêutico ou de diagnóstico de saúde. Nenhuma informação fornecida deve ser interpretada como consulta médica, prescrição dietética ou substituto para a orientação de profissionais de saúde qualificados."
                ),
                TermsClause(
                    number: "7.2.",
                    title: "Alergias e Condições de Saúde Específicas",
                    text: "O aplicativo não analisa nem garante a isenção de alérgenos, contaminação cruzada ou a adequação de receitas para indivíduos com restrições alimentares específicas (como alergias graves, doença celíaca, intolerâncias ou diabetes). É de responsabilidade única e exclusiva do usuário conferir os rótulos de produtos físicos e consultar profissionais capacitados."
                ),
                TermsClause(
                    number: "7.3.",
                    title: "Natureza Estimativa dos Dados",
                    text: "Os valores nutricionais exibidos (calorias, macronutrientes e micronutrientes) constituem estimativas médias obtidas de tabelas públicas e podem variar segundo o modo de preparo, marca, safra ou origem dos ingredientes."
                ),
                TermsClause(
                    number: "7.4.",
                    title: "Garantias Legais (CDC, Arts. 25 e 51)",
                    text: "O aplicativo é fornecido \"como está\" e \"conforme disponível\". As limitações de responsabilidade aplicam-se no limite permitido pela legislação brasileira, resguardando-se os direitos inafastáveis do consumidor no caso de falhas operacionais comprovadas da própria aplicação."
                )
            ]
        ),
        TermsSection(
            number: "8",
            title: "Proteção de Dados Pessoais e Telemetria (LGPD)",
            icon: "lock.shield.fill",
            tintColor: .green,
            clauses: [
                TermsClause(
                    number: "8.1.",
                    text: "Em conformidade com a Lei Geral de Proteção de Dados Pessoais (Lei nº 13.709/2018 - LGPD), o aplicativo adota o princípio da minimização, coletando apenas o primeiro nome informado pelo usuário para personalização local da interface, mas informá-lo é opcional."
                ),
                TermsClause(
                    number: "8.2.",
                    title: "Relatórios de Erro",
                    text: "O aplicativo poderá utilizar serviços padronizados das lojas de aplicativos App Store para recebimento de relatórios anônimos de falhas (crash reports) e métricas agregadas de desempenho, sem identificação pessoal direta."
                ),
                TermsClause(
                    number: "8.3.",
                    title: "Direitos do Titular",
                    text: "O usuário poderá exercer seus direitos previstos no Art. 18 da LGPD ou sanar dúvidas sobre privacidade entrando em contato pelo e-mail: Sousa.guilherme850@gmail.com."
                )
            ]
        ),
        TermsSection(
            number: "9",
            title: "Alterações nos Serviços e Atualizações",
            icon: "arrow.triangle.2.circlepath.circle.fill",
            tintColor: .cyan,
            clauses: [
                TermsClause(
                    number: "9.1.",
                    title: "Atualizações",
                    text: "Os desenvolvedores reservam-se o direito de atualizar o aplicativo para correções de segurança, melhorias de desempenho ou evolução técnica."
                ),
                TermsClause(
                    number: "9.2.",
                    title: "Notificação Prévia",
                    text: "Caso ocorram alterações significativas que impactem funcionalidades essenciais, os usuários serão notificados com antecedência razoável por aviso ostensivo no aplicativo (in-app notice) ou nas notas de versão da loja."
                )
            ]
        ),
        TermsSection(
            number: "10",
            title: "Procedimento de Encerramento de Acesso",
            icon: "trash.circle.fill",
            tintColor: .pink,
            clauses: [
                TermsClause(
                    number: "10.1.",
                    text: "O usuário poderá encerrar o uso do aplicativo a qualquer momento. Como solicitamos apenas o primeiro nome e os dados sobre as receitas são armazenados localmente no dispositivo, a simples exclusão ou desinstalação do aplicativo removerá as informações armazenadas."
                )
            ]
        ),
        TermsSection(
            number: "11",
            title: "Legislação Aplicável e Foro do Domicílio do Consumidor",
            icon: "building.columns.fill",
            tintColor: .brown,
            clauses: [
                TermsClause(
                    number: "11.1.",
                    title: "Legislação Aplicável",
                    text: "Estes Termos são regidos e interpretados em conformidade com as leis do Brasil, incluindo o Código de Defesa do Consumidor (CDC - Lei nº 8.078/1990), a Lei Geral de Proteção de Dados (LGPD - Lei nº 13.709/2018), o Marco Civil da Internet (Lei nº 12.965/2014) e o Estatuto Digital da Criança e do Adolescente (Lei nº 15.211/2025)."
                ),
                TermsClause(
                    number: "11.2.",
                    title: "Foro Competente",
                    text: "Em estrito cumprimento ao disposto no Art. 101, I, do Código de Defesa do Consumidor e no Art. 63 do Código de Processo Civil, fica eleito o Foro do Domicílio do Consumidor para dirimir eventuais dúvidas ou controvérsias decorrentes destes Termos de Uso."
                )
            ]
        ),
        TermsSection(
            number: "12",
            title: "Vigência e Entrada em Vigor",
            icon: "calendar.badge.checkmark",
            tintColor: .teal,
            clauses: [
                TermsClause(
                    number: "12.1.",
                    text: "Estes Termos e Condições de Uso entram em vigor a partir de 14 de outubro de 2026, data de disponibilização e publicação oficial do aplicativo nas lojas de aplicativos App Store."
                )
            ]
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Leia com atenção as condições de uso, privacidade e responsabilidades do aplicativo Na Medida.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                MeasureWarningCard(
                    cardTitle: "Privacidade e Armazenamento Local",
                    cardBody: "Suas receitas ficam salvas apenas no seu próprio dispositivo.\nVigência a partir de 14 de outubro de 2026."
                )
                
                VStack(spacing: 16) {
                    ForEach(sections) { section in
                        TermsSectionCard(section: section)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
        .navigationTitle("Termos de Uso")
        .navigationBarTitleDisplayMode(.large)
    }
}

private struct TermsSectionCard: View {
    @Environment(\.colorScheme) private var colorScheme
    let section: TermsSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack(spacing: 14) {
                Image(systemName: section.icon)
                    .font(.title3)
                    .foregroundStyle(section.tintColor)
                    .frame(width: 46, height: 46)
                    .background {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(section.tintColor.opacity(0.12))
                    }
                
                Text("\(section.number). \(section.title)")
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer(minLength: 0)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 14) {
                ForEach(section.clauses) { clause in
                    VStack(alignment: .leading, spacing: 8) {
                        
                        clauseText(for: clause)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        if !clause.bullets.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(clause.bullets, id: \.self) { bullet in
                                    HStack(alignment: .top, spacing: 10) {
                                        Circle()
                                            .fill(section.tintColor)
                                            .frame(width: 6, height: 6)
                                            .padding(.top, 6)
                                        
                                        Text(bullet)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                            .lineSpacing(3)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                            }
                            .padding(.leading, 8)
                            .padding(.top, 2)
                        }
                    }
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(colorScheme == .dark ? Color(.secondarySystemBackground) : .white)
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 10,
                    x: 0,
                    y: 4
                )
        }
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(.secondary.opacity(0.2), lineWidth: 1.5)
        }
    }
    
    private func clauseText(for clause: TermsClause) -> Text {
        let numberText = Text("\(clause.number) ")
            .fontWeight(.semibold)
            .foregroundStyle(.primary)
        
        if let title = clause.title {
            let titleText = Text("\(title): ")
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            return Text("\(numberText)\(titleText)\(clause.text)")
        } else {
            return Text("\(numberText)\(clause.text)")
        }
    }
}

#Preview {
    NavigationStack {
        TermsOfUseView()
    }
}
