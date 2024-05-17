//
//  WidgetNetworkManager.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 29/04/2024.
//

import Commons
import Foundation

final class WidgetNetworkManager {
    
    static let shared = WidgetNetworkManager()
    
    func getDataFromNBP(from date: Date, completion: @escaping (Result<Exchange, WidgetNetworkError>) -> Void) {
        let fromDate = Formatters.Date.createString(from: date, with: .shortDate)
        let today = Formatters.Date.createString(from: Date(), with: .shortDate)
        
        let endpoint = "https://api.nbp.pl/api/exchangerates/rates/a/eur/\(fromDate)/\(today)/?format=json"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.other(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.statusCode(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let exchangeRates = try JSONDecoder().decode(Exchange.self, from: data)
                completion(.success(exchangeRates))
            } catch {
                completion(.failure(.decodingError(error)))
            }
            
        }.resume()
    }
    
    // *
    func getDataFromNBP(from date: Date, currency: String) async throws -> Exchange {
        let fromDate = Formatters.Date.createString(from: date, with: .shortDate)
        let today = Formatters.Date.createString(from: Date(), with: .shortDate)
    
        let endpoint = "https://api.nbp.pl/api/exchangerates/rates/a/\(currency)/\(fromDate)/\(today)/?format=json"
    
        print("seba widget: \(endpoint)")
        
        guard let url = URL(string: endpoint) else {
            throw WidgetNetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw WidgetNetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            break 
        case 400, 404:
            throw WidgetNetworkError.statusCode(httpResponse.statusCode)
        default:
            throw WidgetNetworkError.noData
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Exchange.self, from: data)
        } catch {
            throw WidgetNetworkError.decodingError(error)
        }
    }

}
