//
//  AppleProductsService.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 29/09/2024.
//

import Foundation

final class AppleProductsService: StoreDataService {

    static let shared = AppleProductsService()
    
    private init() {}
    
    func fetchStoreData(from json: String) async throws -> AppleStoreData {
        return try await downloadStoreData(from: json)
    }
    
    private func downloadStoreData(from json: String) async throws -> AppleStoreData {
        guard let jsonData = json.data(using: .utf8) else {
            throw NSError(domain: "AppleProductsService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Błąd konwersji ciągu znaków na dane"])
        }
        
        do {
            let decoder = JSONDecoder()
            let storeData = try decoder.decode(AppleStoreData.self, from: jsonData)
            return storeData
        } catch {
            throw NSError(domain: "AppleProductsService", code: 2, userInfo: [NSLocalizedDescriptionKey: "Błąd dekodowania JSON: \(error.localizedDescription)"])
        }
    }
    
}
