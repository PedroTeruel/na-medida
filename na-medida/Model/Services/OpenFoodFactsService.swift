//
//  OpenFoodFactsService.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 28/09/26.
//

import Foundation
import Observation

@Observable
final class OpenFoodFactsService {
    private let baseURL = "https://world.openfoodfacts.org/api/v3/product"
    private let searchURL = "https://world.openfoodfacts.org/cgi/search.pl"
    private let userAgent = "NaMedida - iOS - Version 1.0 - pedrohteruel@gmail.com"
    private let fieldsList = "code,product_name,brands,ingredients_text,nutriments,image_front_url,image_url,image_small_url,serving_size,quantity,allergens,countries_tags"
    
    private let decoder = JSONDecoder()
    
    // Busca por código de barras
    func fetchProd(barcode: String) async throws -> ProductOpenFoodFactsDTO {
        let cleanBarcode = barcode.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanBarcode.isEmpty,
              var components = URLComponents(string: "\(baseURL)/\(cleanBarcode)") else {
            throw OpenFoodFactsError.invalidURL
        }
        
        components.queryItems = [
            URLQueryItem(name: "fields", value: fieldsList),
            URLQueryItem(name: "lc", value: "pt")
        ]
        
        guard let url = components.url else {
            throw OpenFoodFactsError.invalidURL
        }
        
        let responseDTO: BarcodeResponseDTO = try await performRequest(url: url, treat404AsNotFound: true)
        
        guard let product = responseDTO.product else {
            throw OpenFoodFactsError.productNotFound
        }
        
        return product
    }
    
    // Função de pesquisa por texto
    func searchProducts(query: String) async throws -> [ProductOpenFoodFactsDTO] {
        let cleanQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanQuery.isEmpty,
              var components = URLComponents(string: searchURL) else {
            throw OpenFoodFactsError.invalidURL
        }
        
        components.queryItems = [
            URLQueryItem(name: "search_terms", value: cleanQuery),
            URLQueryItem(name: "search_simple", value: "1"),
            URLQueryItem(name: "action", value: "process"),
            URLQueryItem(name: "json", value: "1"),
            
            URLQueryItem(name: "tagtype_0", value: "countries"),
            URLQueryItem(name: "tag_contains_0", value: "contains"),
            URLQueryItem(name: "tag_0", value: "brazil"),
            
            URLQueryItem(name: "tagtype_1", value: "states"),
            URLQueryItem(name: "tag_contains_1", value: "contains"),
            URLQueryItem(name: "tag_1", value: "en:nutrition-facts-completed"),
            
            URLQueryItem(name: "page_size", value: "20"),
            URLQueryItem(name: "lc", value: "pt"),
            URLQueryItem(name: "sort_by", value: "unique_scans_n"),
            URLQueryItem(name: "fields", value: fieldsList)
        ]
        
        guard let url = components.url else {
            throw OpenFoodFactsError.invalidURL
        }
        
        do {
            let responseDTO: SearchResponseDTO = try await performRequest(url: url, treat404AsNotFound: true)
            return responseDTO.products ?? []
        } catch OpenFoodFactsError.productNotFound {
            return []
        }
    }
    
    private func performRequest<T: Decodable>(url: URL, treat404AsNotFound: Bool) async throws -> T {
        var request = URLRequest(url: url, timeoutInterval: 15.0)
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
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
                    return try decoder.decode(T.self, from: data)
                case 404 where treat404AsNotFound:
                    throw OpenFoodFactsError.productNotFound
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
                
                try await Task.sleep(nanoseconds: totalDelay)
            }
        }
        
        throw OpenFoodFactsError.invalidResponse
    }
}

enum OpenFoodFactsError: LocalizedError {
    case invalidURL
    case invalidResponse
    case productNotFound
    case serverError(statusCode: Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Endereço de busca inválido."
        case .invalidResponse:
            return "Não foi possível obter resposta do servidor."
        case .productNotFound:
            return "Produto não encontrado."
        case .serverError(let statusCode):
            return "Erro no servidor (código \(statusCode)). Tente novamente."
        }
    }
}
