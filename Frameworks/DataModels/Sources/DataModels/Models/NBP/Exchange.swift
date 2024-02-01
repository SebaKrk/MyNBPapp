//
//  Exchange.swift
//
//
//  Created by Sebastian Sciuba on 01/02/2024.
//

public struct Exchange: Codable, Hashable {
    
    let table: String
    let currency: String
    let code: String
    let rates: [ExchangeRate]
    
}
