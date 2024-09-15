//
//  SearchError.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 15/09/2024.
//

import Foundation

// MARK: - SearchError
/// Custom error type to handle different errors during the search operation.
/// > Important: This enum helps provide clear and meaningful error messages,
/// following the principle of **Single Responsibility**. Each case handles a specific type of error.
enum SearchError: Error, Identifiable {
    case emptyQuery
    case noResults
    case requestFailed(Error)
    case unknownError

    var id: String {
        switch self {
        case .emptyQuery:
            return "emptyQuery"
        case .noResults:
            return "noResults"
        case .requestFailed(let error):
            return "requestFailed:\(error.localizedDescription)"
        case .unknownError:
            return "unknownError"
        }
    }

    /// Returns a user-friendly error message for each case
    var errorMessage: String {
        switch self {
        case .emptyQuery:
            return String(localized: "The search query is empty. Please provide a query.", comment: "Empty Query")
        case .noResults:
            return String(localized: "No results were found for your query.", comment: "No Results")
        case .requestFailed(let error):
            return String(localized: "The request failed due to: \(error.localizedDescription).", comment: "Request Failed")
        case .unknownError:
            return String(localized: "An unknown error occurred. Please try again.",comment: "Unknown Error")
        }
    }
}
