//
//  ApplePayPaymentProcessor.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import Foundation

struct ApplePayPaymentProcessor: PaymentProcessor {
    
    func processPayment(amount: Double) {
        print("Processing ApplePay payment of \(amount) dollars")
    }
    
}
 
