//
//  PayPalPaymentProcessor.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import Foundation

struct PayPalPaymentProcessor: PaymentProcessor {
    
    func processPayment(amount: Double) {
        print("Processing PayPal payment of \(amount) dollars")
    }
    
}
