//
//  OpenFoodFactsDTO.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 28/09/26.
//

import Foundation

//reposta do barcode
struct ProductResponseDTO: Decodable {
    let code: String? //guarda o numero do codigo de barras
    let product: ProductOpenFoodFactsDTO?
    let status: Int?
}

//pesquisa por texto
struct SearchResponseDTO: Decodable {
    let count: Int? //numero de itens encontrados na pesquisa
    let products: [ProductOpenFoodFactsDTO]? //lista para armazenar os resultados da pesquisa
}

// objeto do produto utilizado pelo barcode e search
struct ProductOpenFoodFactsDTO: Decodable {
    let productName: String?
    let brands: String?
    let nutriments: NutrimentsDTO? //guarda tabela nutricional
    
    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case brands
        case nutriments
    }
}

//tabela nutricional do produto
struct NutrimentsDTO: Decodable {
    let energyKcal100g: Double?
    let proteins100g: Double?
    let carbohydrates100g: Double?
    let fat100g: Double?
    
    enum CodingKeys: String, CodingKey {
        case energyKcal100g = "energy-kcal_100g"
        case proteins100g = "proteins_100g"
        case carbohydrates100g = "carbohydrates_100g"
        case fat100g = "fat_100g"
    }
}

//protocolo decodable serve para usar o JSONdecoder
//CodingKeys traduz o padrao snake_case da API para camelCase
