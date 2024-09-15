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
enum SearchError: Error {
    case emptyQuery
    case noResults
    case requestFailed(Error)
    case unknownError

    /// Returns a user-friendly error message for each case
    var errorMessage: String {
        switch self {
        case .emptyQuery:
            return "The search query is empty. Please provide a query."
        case .noResults:
            return "No results were found for your query."
        case .requestFailed(let error):
            return "The request failed due to: \(error.localizedDescription)."
        case .unknownError:
            return "An unknown error occurred. Please try again."
        }
    }
}
