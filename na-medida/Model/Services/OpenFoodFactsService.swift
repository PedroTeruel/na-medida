//
//  OpenFoodFactsService.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 28/09/26.
//

import Foundation

final class OpenFoodFactsService{
    private let baseURL = "https://world.openfoodfacts.org/api/v3/product"
    func fetchProd(barcode: String) async throws -> Product{
        var components = URLComponents(
            string:"\(baseURL)/\(barcode)"
        )
        
        components?.queryItems = [
            URLQueryItem(
                name: "fields",
                value: "code,product_name,brands,ingredients_text,nutriments"
            )
        ]
    }
}
