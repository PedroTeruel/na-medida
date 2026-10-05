//
//  OpenFoodFactsService.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 28/09/26.
//

import Foundation
import Observation

@Observable

//busca por código de barras
final class OpenFoodFactsService {
    private let baseURL = "https://world.openfoodfacts.org/api/v3/product"
    
    private let decoder = JSONDecoder()
    
    func fetchProd(barcode: String) async throws -> ProductOpenFoodFactsDTO {
        var components = URLComponents(
            string:"\(baseURL)/\(barcode)"
        )
        
        components?.queryItems = [
            URLQueryItem(
                name: "fields",
                value: "code, product_name, brands, ingredients_text, nutriments, image_url, serving_size, allergens, countries_tags"),
            URLQueryItem(name: "lc", value: "pt")
        ]
        
        guard let url = components?.url else {
            throw OpenFoodFactsError.invalidURL
        }
        
        var request = URLRequest(url: url, timeoutInterval: 10.0)
        
        request.setValue(
            "NaMedida - IOS - Version 1.0 - pedrohteruel@gmail.com",
            forHTTPHeaderField: "User-Agent"
        )
        
        let maxRetries = 3
        var currentAttempt = 0
        
        while currentAttempt < maxRetries {
            
            try Task.checkCancellation()
            do
            {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                if let jsonPuro = String(data: data, encoding: .utf8) {
                    print("Dados da API (Tentativa \(currentAttempt + 1)): \(jsonPuro)")
                }
                
                guard let webResponse = response as? HTTPURLResponse else {
                    throw OpenFoodFactsError.invalidResponse
                }
                
                switch webResponse.statusCode {
                case 200:
                    let responseDTO = try JSONDecoder().decode(
                        BarcodeResponseDTO.self,
                        from: data
                    )
                    
                    guard let product = responseDTO.product else {
                        throw OpenFoodFactsError.productNotFound
                    }
                    
                    return product
                    
                case 404:
                    throw OpenFoodFactsError.productNotFound
                    
                case 400...499:
                    throw OpenFoodFactsError.serverError(statusCode: webResponse.statusCode)
                    
                default:
                    throw OpenFoodFactsError.serverError(statusCode: webResponse.statusCode)
                }
                
            } catch {
                currentAttempt += 1
                let isNetworkError = (error as? URLError) != nil
                let isServerError: Bool = {
                    
                    if case OpenFoodFactsError.serverError(let statusCode) = error {
                        return statusCode >= 500
                    }
                    return false
                }()
                
                
                if currentAttempt >= maxRetries || (!isNetworkError && !isServerError) ||  Task.isCancelled {
                    throw error
                }
                
                let baseDelay = pow(2.0, Double(currentAttempt - 1))
                let jitter = Double.random(in: 0...0.5)
                let totalDelay = UInt64((baseDelay + jitter) * 1_000_000_000)
                
                try? await Task.sleep(nanoseconds: totalDelay)
            }
        }
        
        throw OpenFoodFactsError.invalidResponse
    }
    
    //função de pesquisa por texto
    func searchProducts(query: String) async throws -> [ProductOpenFoodFactsDTO] {
        var components = URLComponents(string: "https://world.openfoodfacts.org/cgi/search.pl")
        
        components?.queryItems = [
            URLQueryItem(name: "search_terms", value: query),
            URLQueryItem(name: "search_simple", value: "1"),
            URLQueryItem(name: "action", value: "process"),
            URLQueryItem(name: "json", value: "1"),
            URLQueryItem(name: "tagtype_0", value: "countries"),
            URLQueryItem(name: "tag_contains_0", value: "contains"),
            URLQueryItem(name: "tag_0", value: "brazil"),
            URLQueryItem(name: "page_size", value: "20"),
            URLQueryItem(name: "lc", value: "pt"),
            URLQueryItem(name: "sort_by", value: "unique_scans_n"),
            URLQueryItem(name: "fields", value: "product_name, brands, ingredients_text, nutriments, image_url, serving_size, allergens, countries_tags")
        ]
        
        guard let url = components?.url else {
            throw OpenFoodFactsError.invalidURL
        }
        
        var request = URLRequest(url: url, timeoutInterval: 10.0)
        request.setValue(
            "Na-Medida - iOS - Version 1.0 - pedrohteruel@gmail.com",
            forHTTPHeaderField: "User-Agent"
        )
        
        let maxRetries = 3
        var currentAttempt = 0
        
        while currentAttempt < maxRetries {
            try Task.checkCancellation()
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let webResponse = response as? HTTPURLResponse else {
                    throw OpenFoodFactsError.invalidResponse
                }
                
                switch webResponse.statusCode {
                case 200:
                    let responseDTO = try decoder.decode(SearchResponseDTO.self, from: data)
                    return responseDTO.products ?? []
                case 404:
                    return []
                default:
                    throw OpenFoodFactsError.serverError(statusCode: webResponse.statusCode)
                }
            } catch {
                currentAttempt += 1
                let isNetworkError = (error as? URLError) != nil
                let isServerError: Bool = {
                    if case OpenFoodFactsError.serverError(let statusCode) = error {
                        return statusCode >= 500
                    }
                    return false
                }()
                
                if currentAttempt >= maxRetries || (!isNetworkError && !isServerError) || Task.isCancelled {
                    throw error
                }
                
                let baseDelay = pow(2.0, Double(currentAttempt - 1))
                let jitter = Double.random(in: 0...0.5)
                let totalDelay = UInt64((baseDelay + jitter) * 1_000_000_000)
                
                try? await Task.sleep(nanoseconds: totalDelay)
            }
        }
        return []
    }
}

enum OpenFoodFactsError: Error {
    case invalidURL
    case invalidResponse
    case productNotFound
    case serverError(statusCode: Int)
}
