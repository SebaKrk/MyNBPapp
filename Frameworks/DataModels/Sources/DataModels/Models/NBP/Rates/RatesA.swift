//
//  RatesA.swift
//  
//
//  Created by Sebastian Sciuba on 01/02/2024.
//

import Foundation

public struct RatesA: Rate, Equatable {

    public let no: String
    
    public let effectiveDate: String
    
    public let mid: Double
    
    public init(no: String, effectiveDate: String, mid: Double) {
        self.no = no
        self.effectiveDate = effectiveDate
        self.mid = mid
    }
}
