//
//  PrivacyPolicyView.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 16/10/26.
//
import SwiftUI

struct PrivacyClause: Identifiable {
    let id = UUID()
    let number: String
    var title: String? = nil
    let text: String
    var bullets: [String] = []
}

struct PrivacySection: Identifiable {
    let id = UUID()
    let number: String
    let title: String
    let icon: String
    let tintColor: Color
    let clauses: [PrivacyClause]
}

struct PrivacyPolicyView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let supportEmail = "Sousa.guilherme850@gmail.com"
    
    private let sections: [PrivacySection] = [
        PrivacySection(
            number: "1",
            title: "Identificação do Responsável e Contato",
            icon: "person.text.rectangle.fill",
            tintColor: .blue,
            clauses: [
                PrivacyClause(
                    number: "1.1.",
                    text: "O Na Medida é desenvolvido por Guilherme Sales, Pedro Teruel, Rebeca Calmon e Vitor Souza, sendo mantido e disponibilizado por Guilherme Sales."
                ),
                PrivacyClause(
                    number: "1.2.",
                    text: "Para questões relacionadas a esta Política, ao aplicativo e aos direitos sobre dados pessoais, o canal de contato é: Sousa.guilherme850@gmail.com"
                )
            ]
        ),
        PrivacySection(
            number: "2",
            title: "Quais Informações São Tratadas",
            icon: "list.clipboard.fill",
            tintColor: .orange,
            clauses: [
                PrivacyClause(
                    number: "2.1.",
                    text: "O uso do aplicativo Na Medida não exige a criação de conta, senha ou cadastro obrigatório."
                ),
                PrivacyClause(
                    number: "2.2.",
                    title: "Nome",
                    text: "O usuário pode fornecê-lo opcionalmente para personalizar a interface. Essa informação é utilizada e armazenada localmente no próprio dispositivo."
                ),
                PrivacyClause(
                    number: "2.3.",
                    title: "Conteúdo das receitas",
                    text: "Nomes das receitas, ingredientes, quantidades e categorias inseridos pelo usuário são tratados localmente para organizar e calcular informações nutricionais estimadas."
                ),
                PrivacyClause(
                    number: "2.4.",
                    title: "Preferências de uso",
                    text: "Categorias, ordenações e configurações escolhidas pelo usuário podem permanecer registradas no dispositivo para preservar a organização do aplicativo."
                ),
                PrivacyClause(
                    number: "2.5.",
                    title: "Consultas externas",
                    text: "Quando o usuário pesquisa um ingrediente ou produto, o aplicativo transmite à API do Open Food Facts os parâmetros necessários à consulta, como a expressão pesquisada ou identificadores do item. Durante essa conexão, o serviço também pode receber informações técnicas de rede, como o endereço IP."
                ),
                PrivacyClause(
                    number: "2.6.",
                    title: "Contato voluntário",
                    text: "Se o usuário enviar e-mail para suporte, poderão ser tratados seu endereço eletrônico e as informações incluídas na mensagem, exclusivamente para administrar e responder à solicitação e cumprir obrigações legais aplicáveis."
                ),
                PrivacyClause(
                    number: "2.7.",
                    text: "O Na Medida não solicita dados pessoais para suas funções. Informações pessoais eventualmente digitadas pelo usuário em campos de conteúdo livre permanecem armazenadas localmente, de acordo com a finalidade desses campos."
                )
            ]
        ),
        PrivacySection(
            number: "3",
            title: "Finalidades e Fundamentos do Tratamento",
            icon: "target",
            tintColor: .purple,
            clauses: [
                PrivacyClause(
                    number: "3.1.",
                    text: "O nome, quando informado, é utilizado para personalização opcional. Receitas e preferências são utilizadas para permitir cadastro, consulta, edição, organização e cálculo estimado de informações nutricionais."
                ),
                PrivacyClause(
                    number: "3.2.",
                    text: "Os termos e parâmetros de pesquisa são utilizados para solicitar e exibir informações sobre produtos ou ingredientes disponibilizadas pelo serviço da API."
                ),
                PrivacyClause(
                    number: "3.3.",
                    text: "Quando o tratamento estiver sujeito à LGPD, serão observadas as bases legais pertinentes à finalidade específica, inclusive a execução de funcionalidades solicitadas pelo usuário, quando aplicável, e as demais hipóteses previstas no art. 7º da Lei nº 13.709/2018."
                )
            ]
        ),
        PrivacySection(
            number: "4",
            title: "Armazenamento no Dispositivo",
            icon: "iphone.gen3",
            tintColor: .mint,
            clauses: [
                PrivacyClause(
                    number: "4.1.",
                    text: "O acervo de receitas e as informações de personalização descritas nesta Política são armazenados localmente no dispositivo, sem sincronização centralizada de receitas em servidores mantidos pelos desenvolvedores."
                ),
                PrivacyClause(
                    number: "4.2.",
                    text: "Esse armazenamento local não significa que as informações estejam necessariamente fora de cópias de segurança. Dependendo das configurações do dispositivo e dos mecanismos do sistema operacional, conteúdos do aplicativo poderão integrar backups disponibilizados pela Apple."
                ),
                PrivacyClause(
                    number: "4.3.",
                    text: "Os desenvolvedores do Na Medida não possuem nenhum acesso ou painel para visualizar o acervo de receitas armazenado exclusivamente no aparelho do usuário."
                )
            ]
        ),
        PrivacySection(
            number: "5",
            title: "Pesquisa de Ingredientes e Open Food Facts",
            icon: "globe.americas.fill",
            tintColor: .indigo,
            clauses: [
                PrivacyClause(
                    number: "5.1.",
                    text: "Ao realizar uma pesquisa, o Na Medida estabelece comunicação direta entre o dispositivo do usuário e a API do Open Food Facts, serviço de dados de produtos alimentícios de terceiros."
                ),
                PrivacyClause(
                    number: "5.2.",
                    text: "A requisição contém os parâmetros necessários à busca. Por características técnicas da comunicação com a internet, o servidor externo poderá ter acesso a dados de conexão, como endereço IP e cabeçalhos de requisição. O eventual registro, armazenamento e prazo de retenção dessas informações dependem das práticas do operador do serviço externo."
                ),
                PrivacyClause(
                    number: "5.3.",
                    text: "O nome informado no aplicativo e o acervo completo de receitas não são enviados à API para realizar uma pesquisa comum."
                ),
                PrivacyClause(
                    number: "5.4.",
                    text: "As respostas da API são utilizadas para apresentar resultados de pesquisa e informações nutricionais, sujeitas às limitações de cobertura, precisão e atualização da base externa."
                ),
                PrivacyClause(
                    number: "5.5.",
                    text: "A fonte de informações nutricionais do aplicativo também pode incluir dados de referências públicas, como a Tabela Brasileira de Composição de Alimentos (TACO), mencionada nos Termos de Uso. A consulta direta via internet aqui descrita refere-se ao Open Food Facts."
                ),
                PrivacyClause(
                    number: "5.6.",
                    text: "Informações sobre o Open Food Facts e seus termos estão disponíveis em https://world.openfoodfacts.org/ e https://world.openfoodfacts.org/terms-of-use. A infraestrutura de terceiros poderá estar localizada fora do Brasil; quando houver tratamento internacional de dados pessoais, serão observadas as regras legais aplicáveis."
                )
            ]
        ),
        PrivacySection(
            number: "6",
            title: "Compartilhamento e Terceiros",
            icon: "network",
            tintColor: .red,
            clauses: [
                PrivacyClause(
                    number: "6.1.",
                    text: "Os desenvolvedores não mantêm banco de dados próprio centralizado para armazenar o nome do usuário ou seu acervo pessoal de receitas."
                ),
                PrivacyClause(
                    number: "6.2.",
                    text: "A pesquisa nutricional envolve comunicação com o Open Food Facts nos termos da seção 5. Não há, no funcionamento descrito, envio do acervo completo de receitas a esse serviço."
                ),
                PrivacyClause(
                    number: "6.3.",
                    text: "As plataformas responsáveis pela distribuição do aplicativo, pelos serviços do dispositivo e pelo provimento do correio eletrônico poderão tratar dados dentro de suas próprias atribuições e políticas, conforme os serviços efetivamente utilizados."
                ),
                PrivacyClause(
                    number: "6.4.",
                    text: "O Na Medida não tem como finalidade vender dados pessoais ou compartilhar receitas locais para publicidade direcionada."
                )
            ]
        ),
        PrivacySection(
            number: "7",
            title: "Diagnósticos e Relatórios de Falhas",
            icon: "ladybug.fill",
            tintColor: .yellow,
            clauses: [
                PrivacyClause(
                    number: "7.1.",
                    text: "A Apple pode disponibilizar aos desenvolvedores informações relacionadas a falhas, estabilidade e desempenho por meio de seus recursos de análise de aplicativos, conforme a configuração do sistema e as práticas da plataforma."
                ),
                PrivacyClause(
                    number: "7.2.",
                    text: "Esses relatórios poderão conter informações técnicas sobre o aplicativo e seu funcionamento. Não se pressupõe que todo relatório seja integralmente anônimo; seu conteúdo e a possibilidade de identificação dependem do recurso e dos dados envolvidos."
                ),
                PrivacyClause(
                    number: "7.3.",
                    text: "Quando recebidas, essas informações serão utilizadas para corrigir falhas e aprimorar a segurança e o desempenho do Na Medida."
                )
            ]
        ),
        PrivacySection(
            number: "8",
            title: "Conservação e Exclusão dos Dados",
            icon: "trash.fill",
            tintColor: .pink,
            clauses: [
                PrivacyClause(
                    number: "8.1.",
                    text: "Os dados locais permanecem no dispositivo enquanto o usuário os conservar na aplicação. O usuário poderá excluir receitas por meio das funções disponíveis no aplicativo."
                ),
                PrivacyClause(
                    number: "8.2.",
                    text: "A desinstalação do aplicativo normalmente remove seu armazenamento local ativo, conforme o funcionamento do sistema operacional. Cópias de segurança externas ao armazenamento ativo do aplicativo poderão permanecer sujeitas às regras e configurações do respectivo serviço de backup."
                ),
                PrivacyClause(
                    number: "8.3.",
                    text: "O Na Medida não controla diretamente os prazos de retenção de informações técnicas que serviços externos possam registrar em sua própria infraestrutura durante as requisições."
                )
            ]
        ),
        PrivacySection(
            number: "9",
            title: "Segurança da Informação",
            icon: "lock.shield.fill",
            tintColor: .green,
            clauses: [
                PrivacyClause(
                    number: "9.1.",
                    text: "O aplicativo foi concebido para reduzir a exposição de informações pessoais, priorizando armazenamento local e limitando as comunicações externas às funcionalidades que delas dependem."
                ),
                PrivacyClause(
                    number: "9.2.",
                    text: "Recomenda-se manter o sistema atualizado e proteger o acesso ao aparelho. Nenhuma solução tecnológica oferece proteção absoluta contra todos os incidentes."
                )
            ]
        ),
        PrivacySection(
            number: "10",
            title: "Direitos do Titular",
            icon: "person.badge.key.fill",
            tintColor: .cyan,
            clauses: [
                PrivacyClause(
                    number: "10.1.",
                    text: "Nos casos em que a LGPD for aplicável, o titular poderá solicitar, conforme os requisitos legais: confirmação do tratamento, acesso, correção, anonimização, bloqueio ou eliminação de dados, portabilidade quando cabível, informação sobre compartilhamento, revogação de consentimento e revisão das situações previstas em lei."
                ),
                PrivacyClause(
                    number: "10.2.",
                    text: "Como determinadas informações ficam exclusivamente no dispositivo, os desenvolvedores podem não conseguir acessá-las, recuperá-las, alterá-las ou excluí-las remotamente. Nesses casos, o exercício de direitos sobre os dados locais ocorre principalmente por meio das funcionalidades do aplicativo e do sistema operacional."
                ),
                PrivacyClause(
                    number: "10.3.",
                    text: "Pedidos e dúvidas relativos ao tratamento realizado pelos responsáveis pelo Na Medida podem ser encaminhados para Sousa.guilherme850@gmail.com. A resposta observará a legislação aplicável e as limitações técnicas informadas ao titular."
                )
            ]
        ),
        PrivacySection(
            number: "11",
            title: "Crianças e Adolescentes",
            icon: "figure.and.child.holdinghands",
            tintColor: .purple,
            clauses: [
                PrivacyClause(
                    number: "11.1.",
                    text: "O Na Medida é direcionado prioritariamente a pessoas com 18 anos de idade ou mais, conforme seus Termos de Uso, e não implementa, na configuração descrita, uma verificação etária própria."
                ),
                PrivacyClause(
                    number: "11.2.",
                    text: "O eventual tratamento de dados pessoais de crianças e adolescentes deve respeitar as proteções previstas na LGPD e na legislação brasileira aplicável, incluindo o Estatuto Digital da Criança e do Adolescente quando incidente."
                ),
                PrivacyClause(
                    number: "11.3.",
                    text: "Pais e responsáveis poderão encaminhar dúvidas e solicitações ao canal informado na seção 1."
                )
            ]
        ),
        PrivacySection(
            number: "12",
            title: "Alterações Desta Política",
            icon: "arrow.triangle.2.circlepath.circle.fill",
            tintColor: .teal,
            clauses: [
                PrivacyClause(
                    number: "12.1.",
                    text: "Esta Política poderá ser atualizada para refletir mudanças no aplicativo, nos serviços integrados ou na legislação. A versão atualizada indicará a data de sua última modificação."
                ),
                PrivacyClause(
                    number: "12.2.",
                    text: "Alterações relevantes nas práticas de tratamento serão comunicadas de forma adequada aos usuários, por exemplo mediante aviso no aplicativo ou disponibilização da versão atualizada em seu canal oficial."
                )
            ]
        ),
        PrivacySection(
            number: "13",
            title: "Legislação Aplicável e Documentos Relacionados",
            icon: "books.vertical.fill",
            tintColor: .brown,
            clauses: [
                PrivacyClause(
                    number: "13.1.",
                    text: "Esta Política observa a legislação brasileira aplicável, especialmente a Lei nº 13.709/2018 (Lei Geral de Proteção de Dados Pessoais) e a Lei nº 12.965/2014 (Marco Civil da Internet) ."
                ),
                PrivacyClause(
                    number: "13.2.",
                    text: "O presente documento complementa os Termos e Condições de Uso do Na Medida e não afasta direitos assegurados por normas de proteção de dados e de defesa do consumidor."
                ),
                PrivacyClause(
                    number: "13.3.",
                    text: "Texto oficial da LGPD: https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm"
                )
            ]
        ),
        PrivacySection(
            number: "14",
            title: "Canal de Contato",
            icon: "envelope.fill",
            tintColor: .blue,
            clauses: [
                PrivacyClause(
                    number: "14.1.",
                    text: "Se você tiver dúvidas, sugestões ou desejar obter mais informações sobre como tratamos a privacidade e os dados no aplicativo Na Medida, entre em contato com o responsável através do e-mail oficial: Sousa.guilherme850@gmail.com"
                )
            ]
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Saiba como tratamos suas informações e protegemos sua privacidade no aplicativo Na Medida.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                PrivacyWarningCard(
                    cardTitle: "Privacidade e Transparência",
                    cardBody: "Seus dados e receitas ficam armazenados exclusivamente no seu dispositivo. Vigência a partir de 16 de outubro de 2026."
                )
                
                VStack(spacing: 16) {
                    ForEach(sections) { section in
                        PrivacySectionCard(section: section)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
        .navigationTitle("Política de Privacidade")
        .navigationBarTitleDisplayMode(.large)
    }
}

// Cartão de Destaque Superior (semelhante ao de Termos)
private struct PrivacyWarningCard: View {
    let cardTitle: String
    let cardBody: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(cardTitle)
                .font(.headline)
                .foregroundStyle(.primary)
            
            Text(cardBody)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(3)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(16)
    }
}

// Card de Secção individual para a Política
private struct PrivacySectionCard: View {
    @Environment(\.colorScheme) private var colorScheme
    let section: PrivacySection
    
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
    
    private func clauseText(for clause: PrivacyClause) -> Text {
        let numberText = Text("\(clause.number) ")
            .fontWeight(.semibold)
            .foregroundStyle(.primary)
        
        if let title = clause.title {
            let titleText = Text("\(title): ")
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            return numberText + titleText + Text(clause.text)
        } else {
            return numberText + Text(clause.text)
        }
    }
}

#Preview("Política de Privacidade") {
    NavigationStack {
        PrivacyPolicyView()
                }
            }


