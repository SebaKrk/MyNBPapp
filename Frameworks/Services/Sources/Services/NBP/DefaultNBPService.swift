//
//  DefaultNBPService.swift
//
//
//  Created by Sebastian Sciuba on 01/02/2024.
//

import Commons
import DataModels
import Foundation

protocol NBPServiceBuilder {
    func makeRequestForNBP(table: TableNBP,
                               symbol: GlobalCurrencySymbols,
                               from: Date,
                               to: Date) async throws -> URLRequest
    
    func makeTestRequestFromNBP() async throws -> URLRequest
}

class DefaultNBPServiceRequestBuilder: NBPServiceBuilder {
    
    func makeRequestForNBP(table: TableNBP,
                        symbol: GlobalCurrencySymbols,
                        from: Date,
                        to: Date) async throws -> URLRequest {
        let fromDate = Formatters.Date.createString(from: from, with: .shortDate)
        let toDate = Formatters.Date.createString(from: to, with: .shortDate)
        
        let path = PathBuilder()
            .setPath(.exchangeRates)
            .setRates("rates")
            .setTable(table.rawValue)
            .setSymbol(symbol.title)
            .setStartDate(fromDate)
            .setEndDate(toDate)
            .build()
        
        let queryItems = QueryItemsBuilder()
            .addQueryItem(name: "format", value: "json")
            .build()
        
        let urlBuilder = URLBuilder()
        
        guard let url = urlBuilder.build(path: path, queryItems: queryItems) else {
            throw NetworkingError.invalidURL
        }
        
        return URLRequest(url: url)
    }
    
    func makeTestRequestFromNBP() async throws -> URLRequest {
        let path = PathBuilder()
            .setPath(.exchangeRates)
            .setRates("rates")
            .setTable("a")
            .setSymbol("eur")
            .setStartDate("2024-01-02")
            .setEndDate("2024-01-31")
            .build()
        
        let queryItems = QueryItemsBuilder()
            .addQueryItem(name: "format", value: "json")
            .build()
    
        let urlBuilder = URLBuilder()
        guard let url = urlBuilder.build(path: path, queryItems: queryItems) else {
            throw NetworkingError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response  = response as? HTTPURLResponse else {
            throw NetworkingError.fetchingDataFailed
        }
        
        return URLRequest(url: url)
    }
    
}

public final class DefaultNBPService: NBPService {
    
    public init() {}
    
    public func getDataFromNBP(table: TableNBP,
                               symbol: GlobalCurrencySymbols,
                               from: Date,
                               to: Date) async throws -> Exchange {
        
        let request = try await DefaultNBPServiceRequestBuilder().makeRequestForNBP(table: table, symbol: symbol, from: from, to: to)
        
        let data = try await NetworkingService().perform(request)
        
        let dataNBP = try DataDecoder<Exchange>().decode(data)
        
        return dataNBP

        
//        let fromDate = Formatters.Date.createString(from: from, with: .shortDate)
//        let toDate = Formatters.Date.createString(from: to, with: .shortDate)
//
//        let path = PathBuilder()
//            .setPath(.exchangeRates)
//            .setRates("rates")
//            .setTable(table.rawValue)
//            .setSymbol(symbol.title)
//            .setStartDate(fromDate)
//            .setEndDate(toDate)
//            .build()
//        
//        let queryItems = QueryItemsBuilder()
//            .addQueryItem(name: "format", value: "json")
//            .build()
//        
//        let urlBuilder = URLBuilder()
//        
//        guard let url = urlBuilder.build(path: path, queryItems: queryItems) else {
//            throw NetworkingError.invalidURL
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        guard let response  = response as? HTTPURLResponse else {
//            throw NetworkingError.fetchingDataFailed
//        }
//        
//        switch response.statusCode {
//        case 200:
//            break
//        case 400:
//            let errorString = String(data: data, encoding: .utf8) ?? ""
//            if errorString.contains("Przekroczony limit") {
//                throw NetworkingError.exceededLimit
//            } else {
//                throw NetworkingError.badRequest
//            }
//        case 404:
//            throw NetworkingError.notFound
//        default:
//            throw NetworkingError.fetchingDataFailed
//        }
//        
//        do {
//            let decoder = JSONDecoder()
//            return try decoder.decode(Exchange.self, from: data)
//        } catch {
//            throw NetworkingError.invalidData
//        }
    }
    
    public func getDataFromNBP() async throws -> Exchange {

        let request = try await DefaultNBPServiceRequestBuilder().makeTestRequestFromNBP()
        
        let data = try await NetworkingService().perform(request)
        
        let dataNBP = try DataDecoder<Exchange>().decode(data)
        
        return dataNBP
//        let path = PathBuilder()
//            .setPath(.exchangeRates)
//            .setRates("rates")
//            .setTable("a")
//            .setSymbol("eur")
//            .setStartDate("2024-01-02")
//            .setEndDate("2024-01-31")
//            .build()
//        
//        let queryItems = QueryItemsBuilder()
//            .addQueryItem(name: "format", value: "json")
//            .build()
//    
//        let urlBuilder = URLBuilder()
//        guard let url = urlBuilder.build(path: path, queryItems: queryItems) else {
//            throw NetworkingError.invalidURL
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        guard let response  = response as? HTTPURLResponse else {
//            throw NetworkingError.fetchingDataFailed
//        }
//        
//        switch response.statusCode {
//        case 200:
//            break
//        case 400:
//            let errorString = String(data: data, encoding: .utf8) ?? ""
//            if errorString.contains("Przekroczony limit") {
//                throw NetworkingError.exceededLimit
//            } else {
//                throw NetworkingError.badRequest
//            }
//        case 404:
//            throw NetworkingError.notFound
//        default:
//            throw NetworkingError.fetchingDataFailed
//        }
//        
//        do {
//            let decoder = JSONDecoder()
//            return try decoder.decode(Exchange.self, from: data)
//        } catch {
//            throw NetworkingError.invalidData
//        }
    }
    
}
