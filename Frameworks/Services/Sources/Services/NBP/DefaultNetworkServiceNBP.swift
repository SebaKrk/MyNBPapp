//
//  DefaultNetworkServiceNBP.swift
//
//
//  Created by Sebastian Sciuba on 01/02/2024.
//

import DataModels
import Foundation

public final class DefaultNetworkServiceNBP: NetworkServiceNBP {
    
    public init() {} 
    
    public func getEuroData() async throws -> Exchange {
        let endpoint = "https://api.nbp.pl/api/exchangerates/rates/a/eur/2024-01-01/2024-01-31/?format=json"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkingError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response  = response as? HTTPURLResponse else {
            throw NetworkingError.fetchingDataFailed
        }
        
        switch response.statusCode {
        case 200:
            break
        case 400:
            let errorString = String(data: data, encoding: .utf8) ?? ""
            if errorString.contains("Przekroczony limit") {
                throw NetworkingError.exceededLimit
            } else {
                throw NetworkingError.badRequest
            }
        case 404:
            throw NetworkingError.notFound
        default:
            throw NetworkingError.fetchingDataFailed
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Exchange.self, from: data)
        } catch {
            throw NetworkingError.invalidData
        }
    }
    
}
