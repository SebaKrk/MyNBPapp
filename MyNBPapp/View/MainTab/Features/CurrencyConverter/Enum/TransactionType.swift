//
//  TransactionType.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import Foundation

enum TransactionType: Encodable, CaseIterable {
    
    case buy
    case sales
    
    var title: String {
        switch self {
        case .buy: return "kupić"
        case .sales: return "sprzedać"
        }
    }
}
