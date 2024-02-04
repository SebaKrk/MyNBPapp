//
//  Exchange.swift
//
//
//  Created by Sebastian Sciuba on 01/02/2024.
//

public struct Exchange: Codable, Hashable {
    
    public let table: String
    public let currency: String
    public let code: String
    public let rates: [ExchangeRate]
    
}
