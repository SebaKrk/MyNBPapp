//
//  PaymentView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import SwiftUI

struct PaymentView: View {
        
    let paymentFactory: PaymentFactory
    let amount: Double
                
    var body: some View {
        VStack {
            Button {
                let payment = paymentFactory.createPaymentProcessor()
                payment.processPayment(amount: amount)
            } label: {
                Text("Process Payment")
            }
            
            Button {
                let receiptGenerator = paymentFactory.createReceiptGenerator()
                let receipt = receiptGenerator.generateReceipt(transactionId: "123456789")
                print(receipt)
            } label: {
                Text("Generate Receipt")
            }
        }
    }
    
}
