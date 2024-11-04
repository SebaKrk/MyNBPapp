//
//  NetworkingService.swift
//  Services
//
//  Created by Sebastian Sciuba on 04/11/2024.
//

import Foundation

class NetworkingService {
    func perform(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingError.fetchingDataFailed
        }
        
        try ResponseHandler.handle(httpResponse, data: data)
        
        return data
    }
}
