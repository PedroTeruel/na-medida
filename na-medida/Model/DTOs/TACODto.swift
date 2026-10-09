//
//  TACODto.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 08/10/26.
//

import Foundation

struct TacoDouble: Decodable, Hashable {
    var value: Double?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let doubleValue = try? container.decode(Double.self) {
            value = doubleValue
        } else if let intValue = try? container.decode(Int.self) {
            value = Double(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            let cleanStr = stringValue.replacingOccurrences(of: ",", with: ".").trimmingCharacters(in: .whitespaces)
            value = Double(cleanStr)
        } else {
            value = nil
        }
    }
}

struct TacoItemDTO: Decodable, Hashable {
    let id: Int
    let description: String
    let category: String
    let energy_kcal: TacoDouble?
    let protein_g: TacoDouble?
    let lipid_g: TacoDouble?
    let carbohydrate_g: TacoDouble?
    let fiber_g: TacoDouble?
    let sodium_mg: TacoDouble?
    let calcium_mg: TacoDouble?
    let iron_mg: TacoDouble?
    let zinc_mg: TacoDouble?
    let vitaminC_mg: TacoDouble?
    
    private func getEmoji() -> String {
        let text = description.lowercased()
        
        switch category {
        case "Cereais e derivados":
            if text.contains("arroz") { return "🍚" }
            if text.contains("aveia") { return "🌾" }
            if text.contains("biscoito") || text.contains("bolacha") { return "🍪" }
            if text.contains("bolo") { return "🍰" }
            if text.contains("canjica") || text.contains("mingau") || text.contains("creme") || text.contains("cereais") { return "🥣" }
            if text.contains("farinha") || text.contains("polvilho") || text.contains("fécula") || text.contains("amido") { return "🌾" }
            if text.contains("lasanha") || text.contains("macarrão") || text.contains("nhoque") || text.contains("massa") { return "🍝" }
            if text.contains("pipoca") { return "🍿" }
            if text.contains("polenta") || text.contains("curau") { return "🍮" }
            if text.contains("milho") || text.contains("pamonha") { return "🌽" }
            if text.contains("pastel") { return "🥟" }
            if text.contains("pão") {
                if text.contains("queijo") { return "🧀" }
                if text.contains("francês") { return "🥖" }
                return "🍞"
            }
            if text.contains("torrada") { return "🍞" }
            return "🌾"
            
        case "Verduras, hortaliças e derivados":
            if text.contains("alface") || text.contains("acelga") || text.contains("almeirão") || text.contains("catalonha") || text.contains("chicória") || text.contains("couve") || text.contains("espinafre") || text.contains("mostarda") || text.contains("repolho") || text.contains("rúcula") || text.contains("serralha") || text.contains("taioba") || text.contains("aipo") { return "🥬" }
            if text.contains("batata") {
                if text.contains("frita") || text.contains("chips") { return "🍟" }
                if text.contains("doce") || text.contains("baroa") { return "🍠" }
                return "🥔"
            }
            if text.contains("mandioca") || text.contains("cará") || text.contains("inhame") { return "🥔" }
            if text.contains("cenoura") { return "🥕" }
            if text.contains("beterraba") || text.contains("rabanete") || text.contains("nabo") || text.contains("alho-poró") || text.contains("cebola") { return "🧅" }
            if text.contains("alho") { return "🧄" }
            if text.contains("abóbora") { return "🎃" }
            if text.contains("abobrinha") || text.contains("pepino") || text.contains("chuchu") || text.contains("maxixe") || text.contains("quiabo") || text.contains("jiló") || text.contains("jurubeba") { return "🥒" }
            if text.contains("berinjela") { return "🍆" }
            if text.contains("pimentão") { return "🫑" }
            if text.contains("tomate") { return "🍅" }
            if text.contains("brócolis") || text.contains("couve-flor") { return "🥦" }
            if text.contains("vagem") { return "🫛" }
            if text.contains("palmito") { return "🌴" }
            if text.contains("agrião") || text.contains("alfavaca") || text.contains("caruru") || text.contains("coentro") || text.contains("manjericão") || text.contains("salsa") || text.contains("cebolinha") || text.contains("hortelã") { return "🌿" }
            if text.contains("feijão") || text.contains("broto") { return "🫘" }
            if text.contains("pão") && text.contains("queijo") { return "🧀" }
            if text.contains("nhoque") || text.contains("pastel") { return "🥟" }
            if text.contains("farinha") || text.contains("polvilho") || text.contains("fécula") { return "🌾" }
            if text.contains("azeitona") { return "🫒" }
            return "🥗"
            
        case "Frutas e derivados":
            if text.contains("abacate") { return "🥑" }
            if text.contains("abacaxi") { return "🍍" }
            if text.contains("açaí") || text.contains("jabuticaba") || text.contains("jamelão") || text.contains("mirtilo") { return "🫐" }
            if text.contains("acerola") || text.contains("ciriguela") || text.contains("cereja") { return "🍒" }
            if text.contains("ameixa") || text.contains("pêssego") || text.contains("nectarina") { return "🍑" }
            if text.contains("banana") { return "🍌" }
            if text.contains("cacau") { return "🍫" }
            if text.contains("cajá") || text.contains("caju") || text.contains("manga") || text.contains("mamão") { return "🥭" }
            if text.contains("caqui") { return "🍅" }
            if text.contains("carambola") { return "🌟" }
            if text.contains("cupuaçu") || text.contains("coco") { return "🥥" }
            if text.contains("figo") || text.contains("uva") || text.contains("passas") { return "🍇" }
            if text.contains("atemóia") || text.contains("fruta-pão") || text.contains("graviola") || text.contains("jaca") || text.contains("melão") { return "🍈" }
            if text.contains("goiaba") || text.contains("pera") { return "🍐" }
            if text.contains("jambo") || text.contains("maçã") { return "🍎" }
            if text.contains("kiwi") { return "🥝" }
            if text.contains("laranja") || text.contains("tangerina") || text.contains("mexerica") { return "🍊" }
            if text.contains("limão") { return "🍋" }
            if text.contains("morango") || text.contains("framboesa") || text.contains("amora") { return "🍓" }
            if text.contains("melancia") { return "🍉" }
            return "🍎"
            
        case "Leguminosas e derivados":
            if text.contains("amendoim") { return "🥜" }
            return "🫘"
            
        case "Carnes e derivados":
            if text.contains("frango") || text.contains("ave") || text.contains("peru") { return "🍗" }
            if text.contains("porco") || text.contains("suíno") || text.contains("bacon") || text.contains("linguiça") || text.contains("salsicha") { return "🥓" }
            if text.contains("hambúrguer") { return "🍔" }
            return "🥩"
            
        case "Pescados e frutos do mar":
            if text.contains("camarão") || text.contains("caranguejo") { return "🦐" }
            return "🐟"
            
        case "Leite e derivados":
            if text.contains("queijo") { return "🧀" }
            if text.contains("manteiga") { return "🧈" }
            if text.contains("iogurte") { return "🥣" }
            return "🥛"
            
        case "Ovos e derivados":
            if text.contains("frito") || text.contains("mexido") || text.contains("omelete") { return "🍳" }
            return "🥚"
            
        case "Bebidas":
            if text.contains("café") { return "☕" }
            if text.contains("chá") || text.contains("mate") { return "🍵" }
            if text.contains("suco") { return "🧃" }
            if text.contains("cerveja") { return "🍺" }
            if text.contains("vinho") { return "🍷" }
            return "🥤"
            
        case "Óleos e gorduras":
            if text.contains("azeite") { return "🫒" }
            if text.contains("manteiga") || text.contains("margarina") { return "🧈" }
            return "🛢️"
            
        default:
            if text.contains("mel") { return "🍯" }
            if text.contains("açúcar") || text.contains("doce") || text.contains("bala") { return "🍬" }
            if text.contains("chocolate") { return "🍫" }
            return "🍽️"
        }
    }
    
    func toOpenFoodFactsDTO() -> ProductOpenFoodFactsDTO? {
        var nutrimentsDict: [String: Double] = [:]
        
        if let val = energy_kcal?.value { nutrimentsDict["energy-kcal_100g"] = val }
        if let val = protein_g?.value { nutrimentsDict["proteins_100g"] = val }
        if let val = carbohydrate_g?.value { nutrimentsDict["carbohydrates_100g"] = val }
        if let val = lipid_g?.value { nutrimentsDict["fat_100g"] = val }
        if let val = fiber_g?.value { nutrimentsDict["fiber_100g"] = val }
        if let val = sodium_mg?.value { nutrimentsDict["sodium_100g"] = val }
        if let val = calcium_mg?.value { nutrimentsDict["calcium_100g"] = val }
        if let val = iron_mg?.value { nutrimentsDict["iron_100g"] = val }
        if let val = zinc_mg?.value { nutrimentsDict["zinc_100g"] = val }
        if let val = vitaminC_mg?.value { nutrimentsDict["vitamin-c_100g"] = val }
        
        let productDict: [String: Any] = [
            "product_name": description,
            "brands": "TACO (\(category))",
            "ingredients_text": "Informação baseada na Tabela Brasileira de Composição de Alimentos (TACO).",
            "image_url": getEmoji(),
            "serving_size": "100g",
            "countries_tags": ["taco-\(id)"],
            "nutriments": nutrimentsDict
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: productDict),
              let dto = try? JSONDecoder().decode(ProductOpenFoodFactsDTO.self, from: jsonData) else {
            return nil
        }
        
        return dto
    }
}
