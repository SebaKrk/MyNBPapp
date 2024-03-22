//
//  DefaultNBPService.swift
//
//
//  Created by Sebastian Sciuba on 01/02/2024.
//

import Commons
import DataModels
import Foundation

public final class DefaultNBPService: NBPService {
    
    public init() {}
    
    public func getDataFromNBP(table: TableNBP,
                        symbol: GlobalCurrencySymbols,
                        from: Date,
                        to: Date) async throws -> Exchange {
        
        let fromDate = Formatters.Date.createString(from: from, with: .shortDate)
        let toDate = Formatters.Date.createString(from: to, with: .shortDate)
        let endpoint = "https://api.nbp.pl/api/exchangerates/rates/\(table)/\(symbol.title)/\(fromDate)/\(toDate)/?format=json"
        print(endpoint)
        
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
    
    public func getDataFromNBP() async throws -> Exchange {
        let endpoint = "https://api.nbp.pl/api/exchangerates/rates/a/eur/2024-01-02/2024-01-31/?format=json"
        
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
