//
//  NetworkingError.swift
//
//
//  Created by Sebastian Sciuba on 01/02/2024.
//

import Foundation

public enum NetworkingError: LocalizedError {
    case invalidURL
    case fetchingDataFailed
    case notFound
    case badRequest
    case exceededLimit
    case invalidData
    case internetConnectionLost
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Nie udało się pobrać danych. Błędny adres url",
                                     comment: "Błędny adres url ")
            
        case .fetchingDataFailed:
            return NSLocalizedString("Nie udało się pobrać danych",
                                     comment: "Błąd pobierania danych")
        case .notFound:
            return NSLocalizedString("Brak danych",
                                     comment: "W przypadku braku danych dla prawidłowo określonego zakresu czasowego zwracany jest komunika")
            
        case .badRequest:
            return NSLocalizedString("Nieprawidłowe zapytanie. Sprawdź parametry żądania.",
                                     comment: "W przypadku zadania nieprawidłowo sformułowanych zapytań serwis zwraca komunikat")
            
        case .exceededLimit:
            return NSLocalizedString("Przekroczono dozwolony limit danych.",
                                     comment: "W przypadku zapytania przekraczającego limit zwracanych danych serwis zwróci komunikat ")
      
        case .invalidData:
            return NSLocalizedString("Błędne dane.",
                                     comment: "Niepoprawne dane")
            
        case .internetConnectionLost:
            return NSLocalizedString("Brak połączenia z internetem. Spróbuj ponownie później.",
                                     comment: "Brak połączenia z internetem")
        }
    }
    
}
