//
//  PayPalFactory.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import Foundation

struct PayPalFactory: PaymentFactory {
    
    func createPaymentProcessor() -> any PaymentProcessor {
        return PayPalPaymentProcessor()
    }
    
    func createReceiptGenerator() -> any ReceiptGenerator {
        return PayPalReceiptGenerator()
    }

}
