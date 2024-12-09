//
//  Period.swift
//  DataModels
//
//  Created by Sebastian Sciuba on 09/12/2024.
//

import Foundation

public struct Period: Decodable, Hashable {
    
    public let dateFrom: String
    
    public let dateTo: String
    
    public init(dateFrom: String, dateTo: String) {
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
    
}

public struct Periods: Equatable , Hashable {
        
    /// Current period
    let current: Period
    
    /// Previous period
    let previous: Period
    
    public init(current: Period, previous: Period) {
        self.current = current
        self.previous = previous
    }
    
}

