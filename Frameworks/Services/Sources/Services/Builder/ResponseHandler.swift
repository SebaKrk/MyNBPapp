//
//  ResponseHandler.swift
//  Services
//
//  Created by Sebastian Sciuba on 04/11/2024.
//

import Foundation

public class ResponseHandler {
    
    public static func handle(_ response: HTTPURLResponse, data: Data) throws {
        switch response.statusCode {
        case 200:
            return
        case 400:
            throw NetworkingError.badRequest
        case 404:
            throw NetworkingError.notFound
        default:
            throw NetworkingError.fetchingDataFailed
        }
    }
    
}
