//
//  DefaultNBPServiceRequestBuilder.swift
//  Services
//
//  Created by Sebastian Sciuba on 09/12/2024.
//

import Commons
import DataModels
import Foundation

class DefaultNBPServiceRequestBuilder: NBPServiceBuilder {
    
    func makeTestRequestFromNBP(_ dateFrom: String, _ dateTo: String) async throws -> URLRequest {
        
        let path = PathBuilder()
            .setPath(.exchangeRates)
            .setRates("rates")
            .setTable("a")
            .setSymbol("eur")
            .setStartDate(dateFrom)
            .setEndDate(dateTo)
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
