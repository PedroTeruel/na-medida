//
//  LegalData.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 20/10/26.
//

import Foundation

struct LegalClause: Identifiable {
    let id = UUID()
    let number: String
    var title: String? = nil
    let text: String
    var bullets: [String] = []
}

struct LegalSection: Identifiable {
    let id = UUID()
    let number: String
    let title: String
    let icon: String
    let tintColor: AppColor
    let clauses: [LegalClause]
}

enum LegalData {
    static let supportEmail = "Sousa.guilherme850@gmail.com"
    
    static let termsOfUseSections: [LegalSection] = [
        LegalSection(
            number: "1",
            title: "Identificação do Desenvolvedor e Canal de Atendimento",
            icon: "person.2.badge.gearshape.fill",
            tintColor: .blue,
            clauses: [
                LegalClause(
                    number: "1.1.",
                    text: "O aplicativo Na Medida é desenvolvido por Guilherme Sales, Pedro Teruel, Rebeca Calmon e Vitor Souza, mantido e disponibilizado por Guilherme Sales."
                ),
                LegalClause(
                    number: "1.2.",
                    text: "Para suporte técnico, dúvidas, sugestões ou solicitações relativas a estes Termos de Uso ou ao tratamento de dados, o usuário poderá entrar em contato diretamente pelo e-mail oficial: \(supportEmail)"
                )
            ]
        ),
        LegalSection(
            number: "2",
            title: "Objeto e Mecanismo de Adesão aos Termos",
            icon: "doc.text.magnifyingglass",
            tintColor: .orange,
            clauses: [
                LegalClause(
                    number: "2.1.",
                    title: "Objeto",
                    text: "Estes Termos e Condições de Uso (\"Termos\") regem o acesso e a utilização do aplicativo Na Medida, ferramenta destinada à organização de receitas pessoais, consulta de macronutrientes, pesquisa de ingredientes e visualização de tabelas nutricionais."
                ),
                LegalClause(
                    number: "2.2.",
                    title: "Adesão",
                    text: "Ao utilizar nosso aplicativo, o usuário declara ter lido, compreendido e concordado integralmente com as condições aqui estabelecidas."
                ),
                LegalClause(
                    number: "2.3.",
                    title: "Política de Privacidade",
                    text: "O aplicativo Na Medida não coleta, usa ou armazena dados pessoais. O primeiro nome do usuário é solicitado apenas para personalização local da interface, mas informá-lo é opcional."
                ),
                LegalClause(
                    number: "2.4.",
                    title: "Discordância",
                    text: "Caso o usuário não concorde com qualquer disposição destes Termos, deverá abster-se de utilizar a aplicação."
                )
            ]
        ),
        LegalSection(
            number: "3",
            title: "Elegibilidade e Proteção a Menores",
            icon: "figure.and.child.holdinghands",
            tintColor: .purple,
            clauses: [
                LegalClause(
                    number: "3.1.",
                    title: "Idade Mínima",
                    text: "Embora o aplicativo Na Medida não faça a identificação etária, ele é direcionado a usuários com idade igual ou superior a 18 (dezoito) anos. A utilização por menores de 18 anos ou incapazes é recomendada mediante a supervisão e com a autorização prévia de seus pais ou responsáveis legais."
                )
            ]
        ),
        LegalSection(
            number: "4",
            title: "Descrição dos Serviços, Armazenamento Local e Minimização de Dados",
            icon: "iphone.and.arrow.forward",
            tintColor: .mint,
            clauses: [
                LegalClause(
                    number: "4.1.",
                    title: "Funcionalidades",
                    text: "O aplicativo oferece ferramentas para inserção manual de receitas, consulta a dados nutricionais estimados e organização de acervo culinário."
                ),
                LegalClause(
                    number: "4.2.",
                    title: "Armazenamento Puramente Local",
                    text: "O processamento e o armazenamento do acervo de receitas ocorrem localmente no próprio dispositivo móvel do usuário, não havendo sincronização centralizada em nuvem ou banco de dados externo de receitas de usuários."
                ),
                LegalClause(
                    number: "4.3.",
                    title: "Minimização de Dados Pessoais",
                    text: "Em cumprimento à Lei Geral de Proteção de Dados (LGPD - Lei nº 13.709/2018), solicita-se apenas o nome do usuário para fins de personalização da interface gráfica local."
                )
            ]
        ),
        LegalSection(
            number: "5",
            title: "Licença de Uso e Propriedade Intelectual",
            icon: "c.circle.fill",
            tintColor: .indigo,
            clauses: [
                LegalClause(
                    number: "5.1.",
                    title: "Concessão de Licença",
                    text: "Concede-se ao usuário uma licença de uso de software pessoal, limitada, não exclusiva, intransferível, não sublicenciável e revogável para utilização do aplicativo exclusivamente para fins pessoais e não comerciais (Código Civil, arts. 422 e 473; Lei de Software, Lei nº 9.609/1998)."
                ),
                LegalClause(
                    number: "5.2.",
                    title: "Propriedade Intelectual",
                    text: "O download e a instalação do aplicativo não transferem ao usuário qualquer direito de propriedade intelectual ou comercial sobre o software. Todo o código-fonte, arquitetura, design visual, marca, logotipo e ilustrações pertencem exclusivamente aos seus desenvolvedores."
                ),
                LegalClause(
                    number: "5.3.",
                    title: "Bases de Dados de Terceiros",
                    text: "As informações nutricionais disponibilizadas provêm de bases públicas abertas, incluindo a Tabela Brasileira de Composição de Alimentos (TACO), desenvolvida pelo NEPA/UNICAMP (https://nepa.unicamp.br/publicacoes) com estruturação em JSON por Marcelo Santos sob Licença MIT (Copyright © 2023 Marcelo Santos - https://github.com/marcelosanto/tabela_taco), e o Open Food Facts (https://br.openfoodfacts.org), disponibilizado sob a Open Database License (ODbL) e CC BY-SA, mantendo-se preservados todos os direitos autorais e créditos dos seus autores e mantenedores."
                )
            ]
        ),
        LegalSection(
            number: "6",
            title: "Regras de Conduta e Usos Proibidos",
            icon: "hand.raised.fill",
            tintColor: .red,
            clauses: [
                LegalClause(
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
        LegalSection(
            number: "7",
            title: "Isenção e Limitação de Responsabilidade",
            icon: "exclamationmark.triangle.fill",
            tintColor: .yellow,
            clauses: [
                LegalClause(
                    number: "7.1.",
                    title: "Ausência de Propósito Médico e Clínico",
                    text: "O Na Medida é uma ferramenta puramente informativa e organizacional. O aplicativo NÃO possui propósito médico, clínico, terapêutico ou de diagnóstico de saúde. Nenhuma informação fornecida deve ser interpretada como consulta médica, prescrição dietética ou substituto para a orientação de profissionais de saúde qualificados."
                ),
                LegalClause(
                    number: "7.2.",
                    title: "Alergias e Condições de Saúde Específicas",
                    text: "O aplicativo não analisa nem garante a isenção de alérgenos, contaminação cruzada ou a adequação de receitas para indivíduos com restrições alimentares específicas (como alergias graves, doença celíaca, intolerâncias ou diabetes). É de responsabilidade única e exclusiva do usuário conferir os rótulos de produtos físicos e consultar profissionais capacitados."
                ),
                LegalClause(
                    number: "7.3.",
                    title: "Natureza Estimativa dos Dados",
                    text: "Os valores nutricionais exibidos (calorias, macronutrientes e micronutrientes) constituem estimativas médias obtidas de tabelas públicas e podem variar segundo o modo de preparo, marca, safra ou origem dos ingredientes."
                ),
                LegalClause(
                    number: "7.4.",
                    title: "Garantias Legais (CDC, Arts. 25 e 51)",
                    text: "O aplicativo é fornecido \"como está\" e \"conforme disponível\". As limitações de responsabilidade aplicam-se no limite permitido pela legislação brasileira, resguardando-se os direitos inafastáveis do consumidor no caso de falhas operacionais comprovadas da própria aplicação."
                )
            ]
        ),
        LegalSection(
            number: "8",
            title: "Proteção de Dados Pessoais e Telemetria (LGPD)",
            icon: "lock.shield.fill",
            tintColor: .green,
            clauses: [
                LegalClause(
                    number: "8.1.",
                    text: "Em conformidade com a Lei Geral de Proteção de Dados Pessoais (Lei nº 13.709/2018 - LGPD), o aplicativo adota o princípio da minimização, coletando apenas o primeiro nome informado pelo usuário para personalização local da interface, mas informá-lo é opcional."
                ),
                LegalClause(
                    number: "8.2.",
                    title: "Relatórios de Erro",
                    text: "O aplicativo poderá utilizar serviços padronizados das lojas de aplicativos App Store para recebimento de relatórios anônimos de falhas (crash reports) e métricas agregadas de desempenho, sem identificação pessoal direta."
                ),
                LegalClause(
                    number: "8.3.",
                    title: "Direitos do Titular",
                    text: "O usuário poderá exercer seus direitos previstos no Art. 18 da LGPD ou sanar dúvidas sobre privacidade entrando em contato pelo e-mail: \(supportEmail)."
                )
            ]
        ),
        LegalSection(
            number: "9",
            title: "Alterações nos Serviços e Atualizações",
            icon: "arrow.triangle.2.circlepath.circle.fill",
            tintColor: .cyan,
            clauses: [
                LegalClause(
                    number: "9.1.",
                    title: "Atualizações",
                    text: "Os desenvolvedores reservam-se o direito de atualizar o aplicativo para correções de segurança, melhorias de desempenho ou evolução técnica."
                ),
                LegalClause(
                    number: "9.2.",
                    title: "Notificação Prévia",
                    text: "Caso ocorram alterações significativas que impactem funcionalidades essenciais, os usuários serão notificados com antecedência razoável por aviso ostensivo no aplicativo (in-app notice) ou nas notas de versão da loja."
                )
            ]
        ),
        LegalSection(
            number: "10",
            title: "Procedimento de Encerramento de Acesso",
            icon: "trash.circle.fill",
            tintColor: .pink,
            clauses: [
                LegalClause(
                    number: "10.1.",
                    text: "O usuário poderá encerrar o uso do aplicativo a qualquer momento. Como solicitamos apenas o primeiro nome e os dados sobre as receitas são armazenados localmente no dispositivo, a simples exclusão ou desinstalação do aplicativo removerá as informações armazenadas."
                )
            ]
        ),
        LegalSection(
            number: "11",
            title: "Legislação Aplicável e Foro do Domicílio do Consumidor",
            icon: "building.columns.fill",
            tintColor: .brown,
            clauses: [
                LegalClause(
                    number: "11.1.",
                    title: "Legislação Aplicável",
                    text: "Estes Termos são regidos e interpretados em conformidade com as leis do Brasil, incluindo o Código de Defesa do Consumidor (CDC - Lei nº 8.078/1990), a Lei Geral de Proteção de Dados (LGPD - Lei nº 13.709/2018), o Marco Civil da Internet (Lei nº 12.965/2014) e o Estatuto Digital da Criança e do Adolescente (Lei nº 15.211/2025)."
                ),
                LegalClause(
                    number: "11.2.",
                    title: "Foro Competente",
                    text: "Em estrito cumprimento ao disposto no Art. 101, I, do Código de Defesa do Consumidor e no Art. 63 do Código de Processo Civil, fica eleito o Foro do Domicílio do Consumidor para dirimir eventuais dúvidas ou controvérsias decorrentes destes Termos de Uso."
                )
            ]
        ),
        LegalSection(
            number: "12",
            title: "Vigência e Entrada em Vigor",
            icon: "calendar.badge.checkmark",
            tintColor: .teal,
            clauses: [
                LegalClause(
                    number: "12.1.",
                    text: "Estes Termos e Condições de Uso entram em vigor a partir de 14 de outubro de 2026, data de disponibilização e publicação oficial do aplicativo nas lojas de aplicativos App Store."
                )
            ]
        )
    ]
    
    static let privacyPolicySections: [LegalSection] = [
        LegalSection(
            number: "1",
            title: "Identificação do Responsável e Contato",
            icon: "person.text.rectangle.fill",
            tintColor: .blue,
            clauses: [
                LegalClause(
                    number: "1.1.",
                    text: "O Na Medida é desenvolvido por Guilherme Sales, Pedro Teruel, Rebeca Calmon e Vitor Souza, sendo mantido e disponibilizado por Guilherme Sales."
                ),
                LegalClause(
                    number: "1.2.",
                    text: "Para questões relacionadas a esta Política, ao aplicativo e aos direitos sobre dados pessoais, o canal de contato é: \(supportEmail)"
                )
            ]
        ),
        LegalSection(
            number: "2",
            title: "Quais Informações São Tratadas",
            icon: "list.clipboard.fill",
            tintColor: .orange,
            clauses: [
                LegalClause(
                    number: "2.1.",
                    text: "O uso do aplicativo Na Medida não exige a criação de conta, senha ou cadastro obrigatório."
                ),
                LegalClause(
                    number: "2.2.",
                    title: "Nome",
                    text: "O usuário pode fornecê-lo opcionalmente para personalizar a interface. Essa informação é utilizada e armazenada localmente no próprio dispositivo."
                ),
                LegalClause(
                    number: "2.3.",
                    title: "Conteúdo das receitas",
                    text: "Nomes das receitas, ingredientes, quantidades e categorias inseridos pelo usuário são tratados localmente para organizar e calcular informações nutricionais estimadas."
                ),
                LegalClause(
                    number: "2.4.",
                    title: "Preferências de uso",
                    text: "Categorias, ordenações e configurações escolhidas pelo usuário podem permanecer registradas no dispositivo para preservar a organização do aplicativo."
                ),
                LegalClause(
                    number: "2.5.",
                    title: "Consultas externas",
                    text: "Quando o usuário pesquisa um ingrediente ou produto, o aplicativo transmite à API do Open Food Facts os parâmetros necessários à consulta, como a expressão pesquisada ou identificadores do item. Durante essa conexão, o serviço também pode receber informações técnicas de rede, como o endereço IP."
                ),
                LegalClause(
                    number: "2.6.",
                    title: "Contato voluntário",
                    text: "Se o usuário enviar e-mail para suporte, poderão ser tratados seu endereço eletrônico e as informações incluídas na mensagem, exclusivamente para administrar e responder à solicitação e cumprir obrigações legais aplicáveis."
                ),
                LegalClause(
                    number: "2.7.",
                    text: "O Na Medida não solicita dados pessoais para suas funções. Informações pessoais eventualmente digitadas pelo usuário em campos de conteúdo livre permanecem armazenadas localmente, de acordo com a finalidade desses campos."
                )
            ]
        ),
        LegalSection(
            number: "3",
            title: "Finalidades e Fundamentos do Tratamento",
            icon: "target",
            tintColor: .purple,
            clauses: [
                LegalClause(
                    number: "3.1.",
                    text: "O nome, quando informado, é utilizado para personalização opcional. Receitas e preferências são utilizadas para permitir cadastro, consulta, edição, organização e cálculo estimado de informações nutricionais."
                ),
                LegalClause(
                    number: "3.2.",
                    text: "Os termos e parâmetros de pesquisa são utilizados para solicitar e exibir informações sobre produtos ou ingredientes disponibilizadas pelo serviço da API."
                ),
                LegalClause(
                    number: "3.3.",
                    text: "Quando o tratamento estiver sujeito à LGPD, serão observadas as bases legais pertinentes à finalidade específica, inclusive a execução de funcionalidades solicitadas pelo usuário, quando aplicável, e as demais hipóteses previstas no art. 7º da Lei nº 13.709/2018."
                )
            ]
        ),
        LegalSection(
            number: "4",
            title: "Armazenamento no Dispositivo",
            icon: "iphone.gen3",
            tintColor: .mint,
            clauses: [
                LegalClause(
                    number: "4.1.",
                    text: "O acervo de receitas e as informações de personalização descritas nesta Política são armazenados localmente no dispositivo, sem sincronização centralizada de receitas em servidores mantidos pelos desenvolvedores."
                ),
                LegalClause(
                    number: "4.2.",
                    text: "Esse armazenamento local não significa que as informações estejam necessariamente fora de cópias de segurança. Dependendo das configurações do dispositivo e dos mecanismos do sistema operacional, conteúdos do aplicativo poderão integrar backups disponibilizados pela Apple."
                ),
                LegalClause(
                    number: "4.3.",
                    text: "Os desenvolvedores do Na Medida não possuem nenhum acesso ou painel para visualizar o acervo de receitas armazenado exclusivamente no aparelho do usuário."
                )
            ]
        ),
        LegalSection(
            number: "5",
            title: "Pesquisa de Ingredientes e Open Food Facts",
            icon: "globe.americas.fill",
            tintColor: .indigo,
            clauses: [
                LegalClause(
                    number: "5.1.",
                    text: "Ao realizar uma pesquisa, o Na Medida estabelece comunicação direta entre o dispositivo do usuário e a API do Open Food Facts, serviço de dados de produtos alimentícios de terceiros."
                ),
                LegalClause(
                    number: "5.2.",
                    text: "A requisição contém os parâmetros necessários à busca. Por características técnicas da comunicação com a internet, o servidor externo poderá ter acesso a dados de conexão, como endereço IP e cabeçalhos de requisição. O eventual registro, armazenamento e prazo de retenção dessas informações dependem das práticas do operador do serviço externo."
                ),
                LegalClause(
                    number: "5.3.",
                    text: "O nome informado no aplicativo e o acervo completo de receitas não são enviados à API para realizar uma pesquisa comum."
                ),
                LegalClause(
                    number: "5.4.",
                    text: "As respostas da API são utilizadas para apresentar resultados de pesquisa e informações nutricionais, sujeitas às limitações de cobertura, precisão e atualização da base externa."
                ),
                LegalClause(
                    number: "5.5.",
                    text: "A fonte de informações nutricionais do aplicativo também pode incluir dados de referências públicas, como a Tabela Brasileira de Composição de Alimentos (TACO), mencionada nos Termos de Uso. A consulta direta via internet aqui descrita refere-se ao Open Food Facts."
                ),
                LegalClause(
                    number: "5.6.",
                    text: "Informações sobre o Open Food Facts e seus termos estão disponíveis em https://world.openfoodfacts.org/ e https://world.openfoodfacts.org/terms-of-use. A infraestrutura de terceiros poderá estar localizada fora do Brasil; quando houver tratamento internacional de dados pessoais, serão observadas as regras legais aplicáveis."
                )
            ]
        ),
        LegalSection(
            number: "6",
            title: "Compartilhamento e Terceiros",
            icon: "network",
            tintColor: .red,
            clauses: [
                LegalClause(
                    number: "6.1.",
                    text: "Os desenvolvedores não mantêm banco de dados próprio centralizado para armazenar o nome do usuário ou seu acervo pessoal de receitas."
                ),
                LegalClause(
                    number: "6.2.",
                    text: "A pesquisa nutricional envolve comunicação com o Open Food Facts nos termos da seção 5. Não há, no funcionamento descrito, envio do acervo completo de receitas a esse serviço."
                ),
                LegalClause(
                    number: "6.3.",
                    text: "As plataformas responsáveis pela distribuição do aplicativo, pelos serviços do dispositivo e pelo provimento do correio eletrônico poderão tratar dados dentro de suas próprias atribuições e políticas, conforme os serviços efetivamente utilizados."
                ),
                LegalClause(
                    number: "6.4.",
                    text: "O Na Medida não tem como finalidade vender dados pessoais ou compartilhar receitas locais para publicidade direcionada."
                )
            ]
        ),
        LegalSection(
            number: "7",
            title: "Diagnósticos e Relatórios de Falhas",
            icon: "ladybug.fill",
            tintColor: .yellow,
            clauses: [
                LegalClause(
                    number: "7.1.",
                    text: "A Apple pode disponibilizar aos desenvolvedores informações relacionadas a falhas, estabilidade e desempenho por meio de seus recursos de análise de aplicativos, conforme a configuração do sistema e as práticas da plataforma."
                ),
                LegalClause(
                    number: "7.2.",
                    text: "Esses relatórios poderão conter informações técnicas sobre o aplicativo e seu funcionamento. Não se pressupõe que todo relatório seja integralmente anônimo; seu conteúdo e a possibilidade de identificação dependem do recurso e dos dados envolvidos."
                ),
                LegalClause(
                    number: "7.3.",
                    text: "Quando recebidas, essas informações serão utilizadas para corrigir falhas e aprimorar a segurança e o desempenho do Na Medida."
                )
            ]
        ),
        LegalSection(
            number: "8",
            title: "Conservação e Exclusão dos Dados",
            icon: "trash.fill",
            tintColor: .pink,
            clauses: [
                LegalClause(
                    number: "8.1.",
                    text: "Os dados locais permanecem no dispositivo enquanto o usuário os conservar na aplicação. O usuário poderá excluir receitas por meio das funções disponíveis no aplicativo."
                ),
                LegalClause(
                    number: "8.2.",
                    text: "A desinstalação do aplicativo normalmente remove seu armazenamento local ativo, conforme o funcionamento do sistema operacional. Cópias de segurança externas ao armazenamento ativo do aplicativo poderão permanecer sujeitas às regras e configurações do respectivo serviço de backup."
                ),
                LegalClause(
                    number: "8.3.",
                    text: "O Na Medida não controla diretamente os prazos de retenção de informações técnicas que serviços externos possam registrar em sua própria infraestrutura durante as requisições."
                )
            ]
        ),
        LegalSection(
            number: "9",
            title: "Segurança da Informação",
            icon: "lock.shield.fill",
            tintColor: .green,
            clauses: [
                LegalClause(
                    number: "9.1.",
                    text: "O aplicativo foi concebido para reduzir a exposição de informações pessoais, priorizando armazenamento local e limitando as comunicações externas às funcionalidades que delas dependem."
                ),
                LegalClause(
                    number: "9.2.",
                    text: "Recomenda-se manter o sistema atualizado e proteger o acesso ao aparelho. Nenhuma solução tecnológica oferece proteção absoluta contra todos os incidentes."
                )
            ]
        ),
        LegalSection(
            number: "10",
            title: "Direitos do Titular",
            icon: "person.badge.key.fill",
            tintColor: .cyan,
            clauses: [
                LegalClause(
                    number: "10.1.",
                    text: "Nos casos em que a LGPD for aplicável, o titular poderá solicitar, conforme os requisitos legais: confirmação do tratamento, acesso, correção, anonimização, bloqueio ou eliminação de dados, portabilidade quando cabível, informação sobre compartilhamento, revogação de consentimento e revisão das situações previstas em lei."
                ),
                LegalClause(
                    number: "10.2.",
                    text: "Como determinadas informações ficam exclusivamente no dispositivo, os desenvolvedores podem não conseguir acessá-las, recuperá-las, alterá-las ou excluí-las remotamente. Nesses casos, o exercício de direitos sobre os dados locais ocorre principalmente por meio das funcionalidades do aplicativo e do sistema operacional."
                ),
                LegalClause(
                    number: "10.3.",
                    text: "Pedidos e dúvidas relativos ao tratamento realizado pelos responsáveis pelo Na Medida podem ser encaminhados para \(supportEmail). A resposta observará a legislação aplicável e as limitações técnicas informadas ao titular."
                )
            ]
        ),
        LegalSection(
            number: "11",
            title: "Crianças e Adolescentes",
            icon: "figure.and.child.holdinghands",
            tintColor: .purple,
            clauses: [
                LegalClause(
                    number: "11.1.",
                    text: "O Na Medida é direcionado prioritariamente a pessoas com 18 anos de idade ou mais, conforme seus Termos de Uso, e não implementa, na configuração descrita, uma verificação etária própria."
                ),
                LegalClause(
                    number: "11.2.",
                    text: "O eventual tratamento de dados pessoais de crianças e adolescentes deve respeitar as proteções previstas na LGPD e na legislação brasileira aplicável, incluindo o Estatuto Digital da Criança e do Adolescente quando incidente."
                ),
                LegalClause(
                    number: "11.3.",
                    text: "Pais e responsáveis poderão encaminhar dúvidas e solicitações ao canal informado na seção 1."
                )
            ]
        ),
        LegalSection(
            number: "12",
            title: "Alterações Desta Política",
            icon: "arrow.triangle.2.circlepath.circle.fill",
            tintColor: .teal,
            clauses: [
                LegalClause(
                    number: "12.1.",
                    text: "Esta Política poderá ser atualizada para refletir mudanças no aplicativo, nos serviços integrados ou na legislação. A versão atualizada indicará a data de sua última modificação."
                ),
                LegalClause(
                    number: "12.2.",
                    text: "Alterações relevantes nas práticas de tratamento serão comunicadas de forma adequada aos usuários, por exemplo mediante aviso no aplicativo ou disponibilização da versão atualizada em seu canal oficial."
                )
            ]
        ),
        LegalSection(
            number: "13",
            title: "Legislação Aplicável e Documentos Relacionados",
            icon: "books.vertical.fill",
            tintColor: .brown,
            clauses: [
                LegalClause(
                    number: "13.1.",
                    text: "Esta Política observa a legislação brasileira aplicável, especialmente a Lei nº 13.709/2018 (Lei Geral de Proteção de Dados Pessoais) e a Lei nº 12.965/2014 (Marco Civil da Internet) e, quando pertinente, a Lei nº 15.211/2025 (Estatuto Digital da Criança e do Adolescente)."
                ),
                LegalClause(
                    number: "13.2.",
                    text: "O presente documento complementa os Termos e Condições de Uso do Na Medida e não afasta direitos assegurados por normas de proteção de dados e de defesa do consumidor."
                ),
                LegalClause(
                    number: "13.3.",
                    text: "Texto oficial da LGPD: https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm"
                )
            ]
        ),
        LegalSection(
            number: "14",
            title: "Canal de Contato",
            icon: "envelope.fill",
            tintColor: .blue,
            clauses: [
                LegalClause(
                    number: "14.1.",
                    text: "Se você tiver dúvidas, sugestões ou desejar obter mais informações sobre como tratamos a privacidade e os dados no aplicativo Na Medida, entre em contato com o responsável através do e-mail oficial: \(supportEmail)"
                )
            ]
        )
    ]
}
