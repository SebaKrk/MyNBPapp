//
//  OpenAINetworkingError.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 30/07/2024.
//

import Foundation

enum OpenAINetworkingError: Error {
    case invalidURL
    case invalidResponse(statusCode: Int)
    case decodingError
    case requestFailed
    case unknownError
    case noMessage
    
    var errorMessage: String {
            switch self {
            case .invalidURL:
                return "Invalid URL."
            case .invalidResponse (let statusCode):
                return "Invalid response from the server. Status code: \(statusCode)."
            case .decodingError:
                return "Failed to decode the response."
            case .requestFailed:
                return "Request failed."
            case .unknownError:
                return "An unknown error occurred."
            case .noMessage:
                return "No message received."
            }
        }
}
