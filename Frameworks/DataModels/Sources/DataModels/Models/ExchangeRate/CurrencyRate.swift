//
//  CurrencyRate.swift
//
//
//  Created by Sebastian Sciuba on 25/02/2024.
//

import Foundation

public struct CurrencyRate {
    
    public let currency: String
    
    public let rate: Double
    
    public init(currency: String, rate: Double) {
        self.currency = currency
        self.rate = rate
    }
    
}
