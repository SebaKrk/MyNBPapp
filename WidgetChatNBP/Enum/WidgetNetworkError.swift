//
//  WidgetNetworkError.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 29/04/2024.
//

import Foundation

enum WidgetNetworkError: Error {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case noData
    case decodingError(Error)
    case other(Error)
}

