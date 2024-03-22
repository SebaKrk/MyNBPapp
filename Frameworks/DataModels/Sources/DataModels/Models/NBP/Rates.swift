//
//  Rates.swift
//  
//
//  Created by Sebastian Sciuba on 01/02/2024.
//

import Foundation

public struct RatesA: Rate {

    public let no: String
    
    public let effectiveDate: String
    
    public let mid: Double
    
    public init(no: String, effectiveDate: String, mid: Double) {
        self.no = no
        self.effectiveDate = effectiveDate
        self.mid = mid
    }
}

public struct RatesC: Rate {
    
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
