//
//  Exchange.swift
//
//
//  Created by Sebastian Sciuba on 01/02/2024.
//

import Foundation

public struct Exchange: Decodable, Equatable {
    
    public let table: String
    
    public let currency: String
    
    public let code: String
    
    public var rates: [Rate]
    
    public enum CodingKeys: String, CodingKey {
        case table, currency, code, rates
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        table = try container.decode(String.self, forKey: .table)
        currency = try container.decode(String.self, forKey: .currency)
        code = try container.decode(String.self, forKey: .code)
        
        var ratesArray = try container.nestedUnkeyedContainer(forKey: .rates)
        var rates = [Rate]()
        
        while !ratesArray.isAtEnd {
            if let rateA = try? ratesArray.decode(RatesA.self) {
                rates.append(rateA)
            } else if let rateC = try? ratesArray.decode(RatesC.self) {
                rates.append(rateC)
            }
        }
        
        self.rates = rates
    }
    
    public static func == (lhs: Exchange, rhs: Exchange) -> Bool {
           lhs.table == rhs.table &&
           lhs.currency == rhs.currency &&
           lhs.code == rhs.code 
       }
    
}
