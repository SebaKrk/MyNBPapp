//
//  PaymentService.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/09/2024.
//

import Foundation

class PaymentService: PaymentServiceProtocol {
    
    let paymentProcessor: PaymentProcessor
    let receiptGenerator: ReceiptGenerator
    
    init(factory: PaymentFactory) {
        self.paymentProcessor = factory.createPaymentProcessor()
        self.receiptGenerator = factory.createReceiptGenerator()
    }
    
    func processPayment(amount: Double) async throws -> Receipt {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        let paymentSuccessful = mockServerResponse(for: amount)
        
        if paymentSuccessful {
            return receiptGenerator.generateReceipt(transactionId: UUID().uuidString,
                                                    amount: amount,
                                                    date: Date())
        } else {
            throw PaymentError.failed
        }
    }
    
    private func mockServerResponse(for amount: Double) -> Bool {
        return amount > 0.1
    }
}
