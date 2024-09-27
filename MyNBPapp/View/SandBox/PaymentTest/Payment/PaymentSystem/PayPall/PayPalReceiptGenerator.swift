//
//  PayPalReceiptGenerator.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import Foundation

struct PayPalReceiptGenerator: ReceiptGenerator {
    
    func generateReceipt(transactionId: String, amount: Double, date: Date) -> Receipt {
        return Receipt(amount: amount,
                       date: date,
                       transactionId: transactionId,
                       note:   "PayPal receipt for transaction: \(transactionId)")
                       
    }
     
}

