//
//  File.swift
//  Services
//
//  Created by Sebastian Sciuba on 13/10/2024.
//

import Foundation

public enum NBPResourcePath: String {
    case cenyzlota = "/api/cenyzlota"
    case exchangeRates = "/api/exchangerates"
}

// ścieżka URL
public class PathBuilder {
    
    private var components = [String]()
    
    private var path: String?
    private var rates: String?
    private var table: String?
    private var symbol: String?
    private var startDate: String?
    private var endDate: String?
    
    func setPath(_ basePath: NBPResourcePath) -> Self {
        components.append(basePath.rawValue)
        return self
    }
    
    func append(_ segment: String) -> Self {
        components.append(segment)
        return self
    }
    
    func setRates(_ rates: String) -> Self {
        components.append(rates)
        return self
    }
    
    func setTable(_ table: String) -> Self {
        components.append(table)
        return self
    }
    
    func setSymbol(_ symbol: String) -> Self {
        components.append(symbol)
        return self
    }
    
    func setStartDate(_ startDate: String) -> Self {
        components.append(startDate)
        return self
    }
    
    func setEndDate(_ endDate: String) -> Self {
        components.append(endDate)
        return self
    }
    
    public func build() -> String {
        return components.joined(separator: "/")
    }
}


