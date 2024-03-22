//
//  NBPService.swift
//
//
//  Created by Sebastian Sciuba on 01/02/2024.
//

import Commons
import DataModels
import Foundation

public protocol NBPService {
    
    func getDataFromNBP() async throws -> Exchange
    
    func getDataFromNBP(table: TableNBP,
                        symbol: GlobalCurrencySymbols,
                        from: Date,
                        to: Date) async throws -> Exchange
    
}
