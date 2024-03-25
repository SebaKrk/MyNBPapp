//
//  RatesC.swift
//  
//
//  Created by Sebastian Sciuba on 22/03/2024.
//

import Foundation

public struct RatesC: Rate, Equatable {
    
    public let no: String
    public let effectiveDate: String
    public let bid: Double
    public let ask: Double
    
    public init(no: String, effectiveDate: String, bid: Double, ask: Double) {
        self.no = no
        self.effectiveDate = effectiveDate
        self.bid = bid
        self.ask = ask
    }
    
}
