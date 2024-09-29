//
//  AppleProductsService.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 29/09/2024.
//

import Foundation

final class AppleProductsService: ProductsService {

    static let shared = AppleProductsService()
    
    private init() {}
    
    func fetchProducts(from json: String) async throws -> [Product] {
        return try await downloadProducts(from: json)
    }
    
    private func downloadProducts(from json: String) async throws -> [Product] {
        guard let jsonData = json.data(using: .utf8) else {
            throw NSError(domain: "AppleProductsService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Błąd konwersji ciągu znaków na dane"])
        }
        
        do {
            let decoder = JSONDecoder()
            let storeData = try decoder.decode(AppleStoreData.self, from: jsonData)
            return storeData.products
        } catch {
            throw NSError(domain: "AppleProductsService", code: 2, userInfo: [NSLocalizedDescriptionKey: "Błąd dekodowania JSON: \(error.localizedDescription)"])
        }
    }
    
}
