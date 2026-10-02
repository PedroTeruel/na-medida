//
//  OpenFoodFactsDTO.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import Foundation

//recebe reposta do barcode
struct BarcodeResponseDTO: Decodable {
    let code: String? //guarda o numero do codigo de barras
    let product: ProductOpenFoodFactsDTO?
    let status: String?
}

//recebe pesquisa por texto
struct SearchResponseDTO: Decodable {
    let count: Int? //numero de itens encontrados na pesquisa
    let products: [ProductOpenFoodFactsDTO]? //lista para armazenar os resultados da pesquisa
}

// objeto do produto utilizado pelo barcode e search
struct ProductOpenFoodFactsDTO: Decodable, Hashable {
    let productName: String?
    let brands: String?
    let nutriments: NutrimentsDTO? //guarda macronitrientes da tabela nutricional
    let composicaoProduto: String? //guarda ingredientes do produto
    let fotoProdutoURL: String?
    let servingSize: String? // ADICIONADO: guarda a descrição da porção (ex: "20 g (2 colheres de sopa)")

    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case brands
        case nutriments
        case composicaoProduto = "ingredients_text"
        case fotoProdutoURL = "image_url"
        case servingSize = "serving_size" //chave da api por porção
    }
}

//tabela nutricional do produto
struct NutrimentsDTO: Decodable, Hashable {
//valores por 100g
    let energyKcal100g: Double?
    let proteins100g: Double?
    let carbohydrates100g: Double?
    let sugars100g: Double?
    let addedSugars100g: Double?
    let fat100g: Double?
    let saturatedFat100g: Double?
    let transFat100g: Double?
    let fiber100g: Double?
    let sodium100g: Double?
    
//valores por porcao de produto
    let energyKcalServing: Double?
    let proteinsServing: Double?
    let carbohydratesServing: Double?
    let sugarsServing: Double?
    let addedSugarsServing: Double?
    let fatServing: Double?
    let saturatedFatServing: Double?
    let transFatServing: Double?
    let fiberServing: Double?
    let sodiumServing: Double?

    enum CodingKeys: String, CodingKey {
        // para 100g
        case energyKcal100g = "energy-kcal_100g"
        case proteins100g = "proteins_100g"
        case carbohydrates100g = "carbohydrates_100g"
        case sugars100g = "sugars_100g"
        case addedSugars100g = "added-sugars_100g"
        case fat100g = "fat_100g"
        case saturatedFat100g = "saturated-fat_100g"
        case transFat100g = "trans-fat_100g"
        case fiber100g = "fiber_100g"
        case sodium100g = "sodium_100g"
        
        // para porção
        case energyKcalServing = "energy-kcal_serving"
        case proteinsServing = "proteins_serving"
        case carbohydratesServing = "carbohydrates_serving"
        case sugarsServing = "sugars_serving"
        case addedSugarsServing = "added-sugars_serving"
        case fatServing = "fat_serving"
        case saturatedFatServing = "saturated-fat_serving"
        case transFatServing = "trans-fat_serving"
        case fiberServing = "fiber_serving"
        case sodiumServing = "sodium_serving"
    }
}

//protocolo decodable serve para usar o JSONdecoder
//CodingKeys traduz o padrao snake_case da API para camelCase
