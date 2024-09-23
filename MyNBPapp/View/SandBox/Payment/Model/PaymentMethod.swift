//
//  PaymentMethod.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import Foundation

enum PaymentMethod: String, Equatable, CaseIterable  {
    case paypal
    case applePay
    
    var title: String {
        switch self {
        case .paypal: return "PayPal"
        case .applePay: return "Apple Pay"
        }
    }
}
