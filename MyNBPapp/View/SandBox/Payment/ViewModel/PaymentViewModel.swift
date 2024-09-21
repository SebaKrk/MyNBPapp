//
//  PaymentViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/09/2024.
//

import SwiftUI

class PaymentViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let paymentFactory: PaymentFactory
    @State var amount: Double = 0
    
    // MARK: - Lifecycle
    
    init(_ paymentFactory: PaymentFactory, amount: Double) {
        self.paymentFactory = paymentFactory
        self.amount = amount
    }
    
    // MARK: - Methods
    
    func processPayment() {
        let payment = paymentFactory.createPaymentProcessor()
        payment.processPayment(amount: amount)
    }
    
    func generateReceipt(transactionId: String) {
        let receiptGenerator = paymentFactory.createReceiptGenerator()
        let receipt = receiptGenerator.generateReceipt(transactionId: transactionId)
        print(receipt)
    }
        
}
