//
//  NutritionalFactsItem.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 01/10/26.
//

import Foundation

//modelo da tabela nutricional
struct NutritionalFactsItem: Identifiable {
    let id = UUID()
    let name: String          // Ex: "Carboidratos (g)"
    let value100g: String     // Ex: "13"
    let valuePortion: String  // Ex: "17"
    let dailyValue: String    // Ex: "%VD" (calculado com base na Anvisa)
    var isIndent: Bool = false // Sub-itens com recuo visual na UI
    var isBold: Bool = false   // Destaque em negrito na UI
}

// extension para mapeamento dados da api (dto)
extension ProductOpenFoodFactsDTO {
    
    // Converte os dados recebidos da DTO para ir para a View
    var nutritionalItems: [NutritionalFactsItem] {
        // Conexão com o DTO via 'self': tenta acessar a propriedade opcional 'nutriments'.
        // O 'guard' age como uma trava de segurança: se 'self.nutriments' for 'nil',
        // interrompe a execução imediatamente e retorna um array vazio [].
        guard let nutriments = self.nutriments else { return [] }
        
        // Helper para formatar valores numéricos com fallback para "-"
        // - Desembrulha o 'Double?' com guard. Se for 'nil', retorna "-".
        // - Usa 'truncatingRemainder' para verificar se é um número inteiro (ex: 10.0 vira "10").
        // - Caso tenha decimais, usa o operador ternário para formatar fixando 1 casa decimal (ex: "10.5").
        func format(_ value: Double?) -> String {
            guard let val = value else { return "-" }
            return val.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(val))" : String(format: "%.1f", val)
        }
        
        // Helper para calcular o %VD (Valores Diários de Referência)
        // - 'dailyReference': É inserido manualmente conforme os valores de referência da Anvisa (IN nº 75/2020),
        //   pois a API do Open Food Facts não fornece os percentuais da legislação brasileira.
        // - 'guard': Valida se o valor do nutriente existe e se a referência é maior que 0 (evita divisão por zero).
        func calculateVD(value: Double?, dailyReference: Double) -> String {
            guard let val = value, dailyReference > 0 else { return "" }
            let vd = Int((val / dailyReference) * 100)
            return "\(vd)"
        }

        // Variáveis locais com os valores por porção para facilitar a montagem da lista
        let energyServing = nutriments.energyKcalServing
        let carbServing = nutriments.carbohydratesServing
        let protServing = nutriments.proteinsServing
        let fatServing = nutriments.fatServing
        let satFatServing = nutriments.saturatedFatServing
        let transFatServing = nutriments.transFatServing
        let fiberServing = nutriments.fiberServing
        let sodiumServing = nutriments.sodiumServing
        
        // Retorna o array de itens mapeados para a View.
        // Os valores de 'dailyReference' seguem a norma Anvisa (IN 75/2020) para dieta de 2000 kcal:
        return [
            // Valor Energético: Referência Anvisa = 2000 kcal
            NutritionalFactsItem(
                name: "Valor energético (kcal)",
                value100g: format(nutriments.energyKcal100g),
                valuePortion: format(energyServing),
                dailyValue: calculateVD(value: energyServing, dailyReference: 2000),
                isBold: true
            ),
            // Carboidratos: Referência Anvisa = 300g
            NutritionalFactsItem(
                name: "Carboidratos (g)",
                value100g: format(nutriments.carbohydrates100g),
                valuePortion: format(carbServing),
                dailyValue: calculateVD(value: carbServing, dailyReference: 300),
                isBold: true
            ),
            // Açúcares Totais: A Anvisa não estabelece %VD oficial, por isso dailyValue é ""
            NutritionalFactsItem(
                name: "Açúcares totais (g)",
                value100g: format(nutriments.sugars100g),
                valuePortion: format(nutriments.sugarsServing),
                dailyValue: "",
                isIndent: true
            ),
            // Açúcares Adicionados: Referência Anvisa = 50g
            NutritionalFactsItem(
                name: "Açúcares adicionados (g)",
                value100g: format(nutriments.addedSugars100g),
                valuePortion: format(nutriments.addedSugarsServing),
                dailyValue: calculateVD(value: nutriments.addedSugarsServing, dailyReference: 50),
                isIndent: true
            ),
            // Proteínas: Referência Anvisa = 50g
            NutritionalFactsItem(
                name: "Proteínas (g)",
                value100g: format(nutriments.proteins100g),
                valuePortion: format(protServing),
                dailyValue: calculateVD(value: protServing, dailyReference: 50),
                isBold: true
            ),
            // Gorduras Totais: Referência Anvisa = 55g
            NutritionalFactsItem(
                name: "Gorduras totais (g)",
                value100g: format(nutriments.fat100g),
                valuePortion: format(fatServing),
                dailyValue: calculateVD(value: fatServing, dailyReference: 55),
                isBold: true
            ),
            // Gorduras Saturadas: Referência Anvisa = 20g
            NutritionalFactsItem(
                name: "Gorduras saturadas (g)",
                value100g: format(nutriments.saturatedFat100g),
                valuePortion: format(satFatServing),
                dailyValue: calculateVD(value: satFatServing, dailyReference: 20),
                isIndent: true
            ),
            // Gorduras Trans: Referência Anvisa = 2g
            NutritionalFactsItem(
                name: "Gorduras trans (g)",
                value100g: format(nutriments.transFat100g),
                valuePortion: format(transFatServing),
                dailyValue: calculateVD(value: transFatServing, dailyReference: 2),
                isIndent: true
            ),
            // Fibras Alimentares: Referência Anvisa = 25g
            NutritionalFactsItem(
                name: "Fibras alimentares (g)",
                value100g: format(nutriments.fiber100g),
                valuePortion: format(fiberServing),
                dailyValue: calculateVD(value: fiberServing, dailyReference: 25),
                isBold: true
            ),
            // Sódio: Referência Anvisa = 2000mg
            NutritionalFactsItem(
                name: "Sódio (mg)",
                value100g: format(nutriments.sodium100g),
                valuePortion: format(sodiumServing),
                dailyValue: calculateVD(value: sodiumServing, dailyReference: 2000),
                isBold: true
            )
        ]
    }
}
