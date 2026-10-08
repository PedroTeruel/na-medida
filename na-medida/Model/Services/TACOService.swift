//
//  TacoService.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 08/10/26.
//

import Foundation
import Observation

@Observable
final class TacoService {
    private var tacoItems: [ProductOpenFoodFactsDTO] = []
    
    init() {
        loadTacoData()
    }
    
    //carrega e decodifica
    private func loadTacoData() {
        guard let url = Bundle.main.url(forResource: "tabela_alimentos", withExtension: "json") else {
            print("Arquivo tabela_alimentos.json não encontrado no Bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let items = try JSONDecoder().decode([TacoItemDTO].self, from: data)
            
            self.tacoItems = items.compactMap { $0.toOpenFoodFactsDTO() }
            print("TACO carregada com sucesso! \(tacoItems.count) alimentos disponíveis.")
        } catch {
            print("Erro ao carregar ou decodificar TACO: \(error)")
        }
    }
    
    //busca local
    func searchProducts(query: String) -> [ProductOpenFoodFactsDTO] {
        guard !query.isEmpty else { return [] }
        
        let lowerQuery = query.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        
        return tacoItems.filter { item in
            let lowerDesc = (item.productName ?? "").folding(options: .diacriticInsensitive, locale: .current).lowercased()
            return lowerDesc.contains(lowerQuery)
        }
    }
}
