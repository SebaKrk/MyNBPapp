//
//  ExchangeRate.swift
//  
//
//  Created by Sebastian Sciuba on 01/02/2024.
//

import Foundation

public struct ExchangeRate: Codable, Hashable {

    public let no: String
    public let effectiveDate: String
    public let mid: Double
    
}
