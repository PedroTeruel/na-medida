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
    let status: Int?
}

//recebe pesquisa por texto
struct SearchResponseDTO: Decodable {
    let count: Int? //numero de itens encontrados na pesquisa
    let products: [ProductOpenFoodFactsDTO]? //lista para armazenar os resultados da pesquisa
}

// objeto do produto utilizado pelo barcode e search
struct ProductOpenFoodFactsDTO: Decodable, Hashable{
    let productName: String?
    let brands: String?
    let nutriments: NutrimentsDTO? //guarda macronitrientes da tabela nutricional
    let composicaoProduto: String? //guarda ingredientes do produto
    let fotoProdutoURL: String?
    
    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case brands
        case nutriments
        case composicaoProduto = "ingredients_text"
        case fotoProdutoURL = "image_url"
    }
}

//tabela nutricional do produto
struct NutrimentsDTO: Decodable, Hashable {
    let energyKcal100g: Double? //calorias
    let proteins100g: Double? //proteinas
    let carbohydrates100g: Double? //carboidratos
    let fat100g: Double? //gorduras
    
    enum CodingKeys: String, CodingKey {
        case energyKcal100g = "energy-kcal_100g"
        case proteins100g = "proteins_100g"
        case carbohydrates100g = "carbohydrates_100g"
        case fat100g = "fat_100g"
    }
}

//protocolo decodable serve para usar o JSONdecoder
//CodingKeys traduz o padrao snake_case da API para camelCase
