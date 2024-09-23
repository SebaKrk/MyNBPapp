//
//  ApplePayFactory.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import Foundation

struct ApplePayFactory: PaymentFactory {
    
    func createPaymentProcessor() -> PaymentProcessor {
        return ApplePayPaymentProcessor()
    }
    
    func createReceiptGenerator() -> ReceiptGenerator {
        return ApplePayReceiptGenerator()
    }
}
