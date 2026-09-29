//
//  OpenFoodFactsService.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 28/09/26.
//

import Foundation

final class OpenFoodFactsService{
    private let baseURL = "https://world.openfoodfacts.org/api/v3/product"
    
    func fetchProd(barcode: String) async throws -> ProductOpenFoodFactsDTO{
        var components = URLComponents(
            string:"\(baseURL)/\(barcode)"
        )
        
        components?.queryItems = [
            URLQueryItem(
                name: "fields",
                value: "code,product_name,brands,ingredients_text,nutriments"
            )
        ]

        guard let url = components?.url else {
            throw OpenFoodFactsError.invalidURL
        }

        var request = URLRequest(url: url)

        request.setValue(
            "Na-Medida",
            forHTTPHeaderField: "User-Agent"
        )

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let webResponse = response as? HTTPURLResponse else {
            throw OpenFoodFactsError.invalidResponse
        }

        switch webResponse.statusCode {

        case 200:
            let responseDTO = try JSONDecoder().decode(
                ProductResponseDTO.self,
                from: data
            )

            guard let product = responseDTO.product else {
                throw OpenFoodFactsError.productNotFound
            }

            return product

        case 404:
            throw OpenFoodFactsError.productNotFound

        default:
            throw OpenFoodFactsError.serverError(
                statusCode: webResponse.statusCode
            )
        }
    }
}

enum OpenFoodFactsError: Error {
    case invalidURL
    case invalidResponse
    case productNotFound
    case serverError(statusCode: Int)
}




