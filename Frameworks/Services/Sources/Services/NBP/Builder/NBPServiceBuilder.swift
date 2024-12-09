//
//  NBPServiceBuilder.swift
//  Services
//
//  Created by Sebastian Sciuba on 09/12/2024.
//

import Commons
import DataModels
import Foundation

protocol NBPServiceBuilder {
    func makeRequestForNBP(table: TableNBP,
                               symbol: GlobalCurrencySymbols,
                               from: Date,
                               to: Date) async throws -> URLRequest
    
    func makeTestRequestFromNBP() async throws -> URLRequest
    
    func makeTestRequestFromNBP(_ dateFrom: String,
                                _ dateTo: String) async throws -> URLRequest
}
